/**
 * Memory Gateway — Core Interface
 * Pattern: Design Desk ops model + MCP-compatible API
 * 
 * All memory mutations go through explicit MemoryOps for:
 * - Audit trail
 * - Undo/replay capability
 * - Backend-agnostic operation
 */

// ═══════════════════════════════════════
// Core Types
// ═══════════════════════════════════════

export type MemoryType = 'fact' | 'preference' | 'decision' | 'entity' | 'session' | 'pattern';
export type MemorySource = 'user' | 'agent' | 'sync';
export type AdapterName = 'insforge' | 'supabase' | 'sqlite';
export type RelationType = 'depends_on' | 'relates_to' | 'contradicts' | 'derived_from';

export interface MemoryEntry {
  id: string;
  type: MemoryType;
  content: string;
  project?: string;
  tags: string[];
  embedding?: number[];
  accessCount: number;
  decayScore: number;
  source: MemorySource;
  createdAt: string;       // ISO 8601
  lastAccessed: string;    // ISO 8601
  archivedAt?: string;
}

export interface Session {
  id: string;
  projectId: string;
  summary?: string;
  opsCount: number;
  startedAt: string;
  endedAt?: string;
  contextSnapshot?: Record<string, unknown>;
}

export interface MemoryLink {
  sourceId: string;
  targetId: string;
  relation: RelationType;
  weight: number;
  createdAt: string;
}

// ═══════════════════════════════════════
// Request/Response Types
// ═══════════════════════════════════════

export interface StorePayload {
  type: MemoryType;
  content: string;
  project?: string;
  tags?: string[];
  source?: MemorySource;
}

export interface RecallOpts {
  project?: string;
  type?: MemoryType;
  tags?: string[];
  limit?: number;
  minDecay?: number;
  semantic?: boolean;
}

export interface GraphResult {
  root: MemoryEntry;
  nodes: MemoryEntry[];
  edges: MemoryLink[];
}

export interface SyncResult {
  pushed: number;
  pulled: number;
  conflicts: number;
  resolvedBy: string;
}

export interface ExportData {
  format: 'json' | 'md' | 'sql';
  memories: MemoryEntry[];
  sessions: Session[];
  links: MemoryLink[];
  exportedAt: string;
}

export interface ImportResult {
  imported: number;
  skipped: number;
  errors: string[];
}

export interface AdapterInfo {
  name: AdapterName;
  status: 'connected' | 'disconnected' | 'error';
  latency?: number;
  memoryCount?: number;
}

export interface HealthStatus {
  gateway: 'ok' | 'degraded' | 'offline';
  activeAdapter: AdapterInfo;
  fallbacks: AdapterInfo[];
  totalMemories: number;
  pendingSyncOps: number;
}

// ═══════════════════════════════════════
// Memory Gateway Interface
// ═══════════════════════════════════════

export interface MemoryGateway {
  // ── Core CRUD (via ops) ──
  store(entry: StorePayload): Promise<MemoryEntry>;
  recall(query: string, opts?: RecallOpts): Promise<MemoryEntry[]>;
  search(embedding: number[], topK?: number): Promise<MemoryEntry[]>;
  update(id: string, patch: Partial<MemoryEntry>): Promise<MemoryEntry>;
  forget(id: string, reason: string): Promise<void>;

  // ── Knowledge Graph ──
  link(sourceId: string, targetId: string, relation: RelationType): Promise<MemoryLink>;
  unlink(sourceId: string, targetId: string): Promise<void>;
  traverse(startId: string, depth?: number): Promise<GraphResult>;

  // ── Sessions ──
  startSession(projectId: string): Promise<Session>;
  endSession(id: string, summary: string): Promise<void>;
  getSession(id: string): Promise<Session>;
  listSessions(projectId: string): Promise<Session[]>;

  // ── Sync & Migration ──
  sync(): Promise<SyncResult>;
  export(format: 'json' | 'md' | 'sql'): Promise<ExportData>;
  import(data: ExportData): Promise<ImportResult>;

  // ── Ops Journal ──
  getOpsLog(sessionId?: string): Promise<MemoryOp[]>;
  replayOps(ops: MemoryOp[]): Promise<void>;

  // ── Adapter Management ──
  getAdapter(): AdapterInfo;
  switchAdapter(name: AdapterName): Promise<void>;
  health(): Promise<HealthStatus>;
}

// ═══════════════════════════════════════
// Memory Operations (Design Desk pattern)
// ═══════════════════════════════════════

export type MemoryOpType = 'store' | 'update' | 'forget' | 'link' | 'unlink' | 'decay';

export interface MemoryOp {
  seq: number;
  opType: MemoryOpType;
  payload: string;         // canonical JSON
  timestamp: string;       // ISO 8601
  sessionId?: string;
  adapter: AdapterName;
}
