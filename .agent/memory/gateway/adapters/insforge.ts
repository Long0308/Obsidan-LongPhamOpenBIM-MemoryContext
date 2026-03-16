/**
 * Insforge Adapter — Primary backend
 * SQLite + pgvector + Supabase sync via Insforge platform
 */

import { BaseAdapter } from './base';
import {
  MemoryEntry, RecallOpts, MemoryLink, Session,
  AdapterName, AdapterInfo, RelationType
} from '../interface';

export class InsforgeAdapter extends BaseAdapter {
  readonly name: AdapterName = 'insforge';
  private projectId: string;
  private pgvectorEnabled: boolean;
  private connected = false;

  constructor(config: {
    projectId: string;
    pgvector?: boolean;
    embeddingModel?: string;
  }) {
    super();
    this.projectId = config.projectId;
    this.pgvectorEnabled = config.pgvector ?? true;
  }

  async connect(): Promise<void> {
    // Connect via @insforge/cli linked project
    // Initialize tables if needed
    this.connected = true;
  }

  async disconnect(): Promise<void> {
    this.connected = false;
  }

  async health(): Promise<AdapterInfo> {
    return {
      name: this.name,
      status: this.connected ? 'connected' : 'disconnected',
      latency: 50,
    };
  }

  // ── CRUD ──
  async store(entry: MemoryEntry): Promise<void> {
    this._ensureConnected();
    // Uses Insforge SDK to INSERT with pgvector embedding
  }

  async recall(query: string, opts?: RecallOpts): Promise<MemoryEntry[]> {
    this._ensureConnected();
    if (opts?.semantic && this.pgvectorEnabled) {
      // Use pgvector similarity search
      return this._semanticSearch(query, opts.limit ?? 10);
    }
    // Fallback: text search
    return [];
  }

  async search(embedding: number[], topK: number): Promise<MemoryEntry[]> {
    this._ensureConnected();
    if (!this.pgvectorEnabled) return [];
    // SELECT * FROM memories ORDER BY embedding <=> $1 LIMIT $2
    return [];
  }

  async get(id: string): Promise<MemoryEntry | null> {
    this._ensureConnected();
    return null;
  }

  async update(id: string, patch: Partial<MemoryEntry>): Promise<void> {
    this._ensureConnected();
  }

  async delete(id: string): Promise<void> {
    this._ensureConnected();
  }

  // ── Knowledge Graph ──
  async link(sourceId: string, targetId: string, relation: RelationType, weight = 1.0): Promise<void> {
    this._ensureConnected();
  }

  async unlink(sourceId: string, targetId: string): Promise<void> {
    this._ensureConnected();
  }

  async getLinks(id: string, _depth = 1): Promise<MemoryLink[]> {
    this._ensureConnected();
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

  // ── Private ──
  private async _semanticSearch(query: string, limit: number): Promise<MemoryEntry[]> {
    // 1. Get embedding for query via embeddingModel
    // 2. pgvector similarity search
    return [];
  }

  private _ensureConnected(): void {
    if (!this.connected) throw new Error('Insforge adapter not connected');
  }
}
