/**
 * SQLite Adapter — Local offline fallback
 * Uses better-sqlite3 or sql.js for local persistence
 * Always available, no network required
 */

import { BaseAdapter } from './base';
import {
  MemoryEntry, RecallOpts, MemoryLink, Session,
  AdapterName, AdapterInfo, RelationType
} from '../interface';

export class SqliteAdapter extends BaseAdapter {
  readonly name: AdapterName = 'sqlite';
  private dbPath: string;
  private connected = false;

  constructor(config: { path: string; walMode?: boolean }) {
    super();
    this.dbPath = config.path;
  }

  async connect(): Promise<void> {
    // In production: initialize better-sqlite3 or sql.js
    // Create tables if not exist using SCHEMA below
    this.connected = true;
  }

  async disconnect(): Promise<void> {
    this.connected = false;
  }

  async health(): Promise<AdapterInfo> {
    return {
      name: this.name,
      status: this.connected ? 'connected' : 'disconnected',
      latency: 1, // local = ~1ms
    };
  }

  // ── CRUD ──
  async store(entry: MemoryEntry): Promise<void> {
    // INSERT INTO memories VALUES (...)
    this._ensureConnected();
  }

  async recall(query: string, opts?: RecallOpts): Promise<MemoryEntry[]> {
    this._ensureConnected();
    // SELECT * FROM memories WHERE content LIKE '%query%'
    // Apply opts filters (project, type, limit, minDecay)
    return [];
  }

  async search(_embedding: number[], _topK: number): Promise<MemoryEntry[]> {
    // SQLite doesn't support vector search natively
    // Fallback: cosine similarity in JS on cached embeddings
    return [];
  }

  async get(id: string): Promise<MemoryEntry | null> {
    this._ensureConnected();
    // SELECT * FROM memories WHERE id = ?
    return null;
  }

  async update(id: string, patch: Partial<MemoryEntry>): Promise<void> {
    this._ensureConnected();
    // UPDATE memories SET ... WHERE id = ?
  }

  async delete(id: string): Promise<void> {
    this._ensureConnected();
    // DELETE FROM memories WHERE id = ?
  }

  // ── Knowledge Graph ──
  async link(sourceId: string, targetId: string, relation: RelationType, weight = 1.0): Promise<void> {
    this._ensureConnected();
    // INSERT INTO memory_links VALUES (...)
  }

  async unlink(sourceId: string, targetId: string): Promise<void> {
    this._ensureConnected();
    // DELETE FROM memory_links WHERE source_id = ? AND target_id = ?
  }

  async getLinks(id: string, _depth = 1): Promise<MemoryLink[]> {
    this._ensureConnected();
    // SELECT * FROM memory_links WHERE source_id = ? OR target_id = ?
    return [];
  }

  // ── Sessions ──
  async createSession(session: Session): Promise<void> {
    this._ensureConnected();
  }

  async updateSession(id: string, patch: Partial<Session>): Promise<void> {
    this._ensureConnected();
  }

  async getSession(id: string): Promise<Session | null> {
    this._ensureConnected();
    return null;
  }

  async listSessions(projectId: string): Promise<Session[]> {
    this._ensureConnected();
    return [];
  }

  // ── Bulk ──
  async getAllMemories(opts?: { project?: string; minDecay?: number }): Promise<MemoryEntry[]> {
    this._ensureConnected();
    return [];
  }

  async count(): Promise<number> {
    this._ensureConnected();
    return 0;
  }

  private _ensureConnected(): void {
    if (!this.connected) throw new Error('SQLite adapter not connected');
  }
}

/**
 * SQLite Schema — run on first connect
 */
export const SQLITE_SCHEMA = `
CREATE TABLE IF NOT EXISTS memories (
  id TEXT PRIMARY KEY,
  type TEXT NOT NULL CHECK (type IN ('fact','preference','decision','entity','session','pattern')),
  content TEXT NOT NULL,
  project_id TEXT,
  tags TEXT,
  embedding BLOB,
  access_count INTEGER DEFAULT 0,
  decay_score REAL DEFAULT 1.0,
  source TEXT DEFAULT 'agent',
  created_at TEXT DEFAULT (datetime('now')),
  last_accessed TEXT DEFAULT (datetime('now')),
  archived_at TEXT
);

CREATE TABLE IF NOT EXISTS sessions (
  id TEXT PRIMARY KEY,
  project_id TEXT NOT NULL,
  summary TEXT,
  ops_count INTEGER DEFAULT 0,
  started_at TEXT DEFAULT (datetime('now')),
  ended_at TEXT,
  context_snapshot TEXT
);

CREATE TABLE IF NOT EXISTS memory_links (
  source_id TEXT REFERENCES memories(id) ON DELETE CASCADE,
  target_id TEXT REFERENCES memories(id) ON DELETE CASCADE,
  relation TEXT NOT NULL,
  weight REAL DEFAULT 1.0,
  created_at TEXT DEFAULT (datetime('now')),
  PRIMARY KEY (source_id, target_id, relation)
);

CREATE TABLE IF NOT EXISTS memory_ops (
  seq INTEGER PRIMARY KEY AUTOINCREMENT,
  op_type TEXT NOT NULL,
  payload TEXT NOT NULL,
  timestamp TEXT DEFAULT (datetime('now')),
  session_id TEXT REFERENCES sessions(id),
  adapter TEXT
);

CREATE INDEX IF NOT EXISTS idx_mem_project ON memories(project_id);
CREATE INDEX IF NOT EXISTS idx_mem_type ON memories(type);
CREATE INDEX IF NOT EXISTS idx_mem_decay ON memories(decay_score) WHERE archived_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_ops_session ON memory_ops(session_id);
`;
