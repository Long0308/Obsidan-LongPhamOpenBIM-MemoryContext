/**
 * SQLite Fallback Adapter — Local-first memory backup
 * Pattern: Write-through cache with periodic sync to InsForge
 * 
 * When InsForge is unreachable:
 * 1. Writes go to local SQLite
 * 2. Reads served from SQLite
 * 3. On reconnect, sync pending ops to InsForge
 */

import Database from 'better-sqlite3';
import { join } from 'path';

const DB_PATH = join(__dirname, '..', 'agent.db');

interface MemoryRow {
  id: string;
  type: string;
  category: string;
  content: string;
  tags: string; // JSON array
  importance: number;
  decay_rate: number;
  source: string;
  synced: number; // 0 = pending, 1 = synced
  created_at: string;
  updated_at: string;
}

export class SQLiteAdapter {
  private db: Database.Database;

  constructor(dbPath = DB_PATH) {
    this.db = new Database(dbPath);
    this.db.pragma('journal_mode = WAL');
    this.init();
  }

  private init() {
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS memories (
        id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
        type TEXT NOT NULL DEFAULT 'long-term',
        category TEXT NOT NULL DEFAULT 'general',
        content TEXT NOT NULL,
        tags TEXT DEFAULT '[]',
        importance REAL DEFAULT 0.5,
        decay_rate REAL DEFAULT 0.01,
        source TEXT DEFAULT 'agent',
        synced INTEGER DEFAULT 0,
        created_at TEXT DEFAULT (datetime('now')),
        updated_at TEXT DEFAULT (datetime('now'))
      );
      CREATE INDEX IF NOT EXISTS idx_local_category ON memories(category);
      CREATE INDEX IF NOT EXISTS idx_local_synced ON memories(synced);
      CREATE INDEX IF NOT EXISTS idx_local_importance ON memories(importance DESC);
    `);
  }

  /** Save memory locally (fallback when InsForge is down) */
  store(entry: Omit<MemoryRow, 'id' | 'synced' | 'created_at' | 'updated_at'>) {
    const stmt = this.db.prepare(`
      INSERT INTO memories (type, category, content, tags, importance, decay_rate, source)
      VALUES (@type, @category, @content, @tags, @importance, @decay_rate, @source)
    `);
    return stmt.run({
      ...entry,
      tags: JSON.stringify(entry.tags)
    });
  }

  /** Get unsynced records for bulk push to InsForge */
  getPending(limit = 50): MemoryRow[] {
    return this.db.prepare(
      'SELECT * FROM memories WHERE synced = 0 ORDER BY created_at ASC LIMIT ?'
    ).all(limit) as MemoryRow[];
  }

  /** Mark records as synced after successful push */
  markSynced(ids: string[]) {
    const placeholders = ids.map(() => '?').join(',');
    this.db.prepare(
      `UPDATE memories SET synced = 1, updated_at = datetime('now') WHERE id IN (${placeholders})`
    ).run(...ids);
  }

  /** Local decay — mirrors the PostgreSQL decay_memories() function */
  runDecay() {
    const decayed = this.db.prepare(`
      UPDATE memories
      SET importance = MAX(importance - (decay_rate * (julianday('now') - julianday(updated_at))), 0),
          updated_at = datetime('now')
      WHERE importance > 0
        AND updated_at < datetime('now', '-1 day')
    `).run();

    const archived = this.db.prepare(`
      UPDATE memories
      SET category = 'archived', updated_at = datetime('now')
      WHERE importance <= 0.1
        AND category != 'archived'
        AND created_at < datetime('now', '-30 day')
    `).run();

    return { decayed: decayed.changes, archived: archived.changes };
  }

  /** Search with basic text matching */
  search(query: string, limit = 10): MemoryRow[] {
    return this.db.prepare(
      'SELECT * FROM memories WHERE content LIKE ? ORDER BY importance DESC LIMIT ?'
    ).all(`%${query}%`, limit) as MemoryRow[];
  }

  /** Get all memories for a project */
  getByProject(project: string, limit = 100): MemoryRow[] {
    return this.db.prepare(
      "SELECT * FROM memories WHERE tags LIKE ? ORDER BY created_at DESC LIMIT ?"
    ).all(`%${project}%`, limit) as MemoryRow[];
  }

  close() {
    this.db.close();
  }
}

/**
 * Usage in auto-memory protocol:
 * 
 * const fallback = new SQLiteAdapter();
 * 
 * // When InsForge is down:
 * fallback.store({ type: 'long-term', category: 'session', ... });
 * 
 * // On reconnect:
 * const pending = fallback.getPending();
 * await pushToInsForge(pending);
 * fallback.markSynced(pending.map(p => p.id));
 */
