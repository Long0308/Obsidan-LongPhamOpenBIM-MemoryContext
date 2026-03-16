/**
 * Base Adapter — Abstract class for Memory Gateway backends
 * All adapters implement this contract → swap with config change only
 */

import {
  MemoryEntry, StorePayload, RecallOpts, MemoryLink,
  Session, AdapterName, AdapterInfo, RelationType
} from '../interface';

export abstract class BaseAdapter {
  abstract readonly name: AdapterName;

  // ── Core CRUD ──
  abstract store(entry: MemoryEntry): Promise<void>;
  abstract recall(query: string, opts?: RecallOpts): Promise<MemoryEntry[]>;
  abstract search(embedding: number[], topK: number): Promise<MemoryEntry[]>;
  abstract get(id: string): Promise<MemoryEntry | null>;
  abstract update(id: string, patch: Partial<MemoryEntry>): Promise<void>;
  abstract delete(id: string): Promise<void>;

  // ── Knowledge Graph ──
  abstract link(sourceId: string, targetId: string, relation: RelationType, weight?: number): Promise<void>;
  abstract unlink(sourceId: string, targetId: string): Promise<void>;
  abstract getLinks(id: string, depth?: number): Promise<MemoryLink[]>;

  // ── Sessions ──
  abstract createSession(session: Session): Promise<void>;
  abstract updateSession(id: string, patch: Partial<Session>): Promise<void>;
  abstract getSession(id: string): Promise<Session | null>;
  abstract listSessions(projectId: string): Promise<Session[]>;

  // ── Bulk ──
  abstract getAllMemories(opts?: { project?: string; minDecay?: number }): Promise<MemoryEntry[]>;
  abstract count(): Promise<number>;

  // ── Lifecycle ──
  abstract connect(): Promise<void>;
  abstract disconnect(): Promise<void>;
  abstract health(): Promise<AdapterInfo>;

  // ── Touch access (update decay/access tracking) ──
  async touchAccess(id: string): Promise<void> {
    const entry = await this.get(id);
    if (entry) {
      await this.update(id, {
        accessCount: entry.accessCount + 1,
        lastAccessed: new Date().toISOString(),
      });
    }
  }
}
