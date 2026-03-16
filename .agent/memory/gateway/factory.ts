/**
 * Memory Gateway Factory
 * Creates a fully configured gateway from gateway.config.json
 * Pattern: Design Desk documentStore — single entry point for all memory ops
 */

import { MemoryGateway, AdapterName, HealthStatus } from './interface';
import { FallbackController } from './middleware/fallback';
import { OpsLogger } from './middleware/opsLogger';
import { DecayManager } from './middleware/decay';
import { InsforgeAdapter } from './adapters/insforge';
import { SupabaseAdapter } from './adapters/supabase';
import { SqliteAdapter } from './adapters/sqlite';

export interface GatewayConfig {
  activeAdapter: AdapterName;
  fallbackChain: AdapterName[];
  adapters: {
    insforge?: {
      enabled: boolean;
      projectId: string;
      pgvector?: boolean;
      embeddingModel?: string;
    };
    supabase?: {
      enabled: boolean;
      projectRef: string;
      schema?: string;
      apiUrl: string;
    };
    sqlite?: {
      enabled: boolean;
      path: string;
      walMode?: boolean;
    };
  };
  ops?: {
    journalEnabled?: boolean;
    maxOpsPerSession?: number;
  };
  decay?: {
    enabled?: boolean;
    threshold?: number;
    inactiveDays?: number;
    checkInterval?: string;
  };
}

/**
 * Create and initialize a Memory Gateway from config
 */
export async function createGateway(config: GatewayConfig): Promise<{
  fallback: FallbackController;
  opsLogger: OpsLogger;
  decayManager: DecayManager;
  health: () => Promise<HealthStatus>;
}> {
  // Initialize adapters
  const fallback = new FallbackController(config.fallbackChain);

  if (config.adapters.insforge?.enabled) {
    fallback.registerAdapter(new InsforgeAdapter({
      projectId: config.adapters.insforge.projectId,
      pgvector: config.adapters.insforge.pgvector,
      embeddingModel: config.adapters.insforge.embeddingModel,
    }));
  }

  if (config.adapters.supabase?.enabled) {
    fallback.registerAdapter(new SupabaseAdapter({
      projectRef: config.adapters.supabase.projectRef,
      schema: config.adapters.supabase.schema,
      apiUrl: config.adapters.supabase.apiUrl,
    }));
  }

  if (config.adapters.sqlite?.enabled) {
    fallback.registerAdapter(new SqliteAdapter({
      path: config.adapters.sqlite.path,
      walMode: config.adapters.sqlite.walMode,
    }));
  }

  // Initialize middleware
  const opsLogger = new OpsLogger({
    maxOpsPerSession: config.ops?.maxOpsPerSession,
  });

  const decayManager = new DecayManager({
    threshold: config.decay?.threshold,
    inactiveDays: config.decay?.inactiveDays,
    checkInterval: config.decay?.checkInterval,
  });

  // Connect all adapters
  await fallback.connectAll();

  // Switch to configured active adapter
  fallback.switchTo(config.activeAdapter);

  // Health check function
  const health = async (): Promise<HealthStatus> => {
    const allHealth = await fallback.healthAll();
    const active = allHealth.find(a => a.name === config.activeAdapter);
    const fallbacks = allHealth.filter(a => a.name !== config.activeAdapter);
    const count = await fallback.execute(a => a.count());

    return {
      gateway: active?.status === 'connected' ? 'ok' : 'degraded',
      activeAdapter: active ?? { name: config.activeAdapter, status: 'error' },
      fallbacks,
      totalMemories: count,
      pendingSyncOps: opsLogger.length,
    };
  };

  return { fallback, opsLogger, decayManager, health };
}
