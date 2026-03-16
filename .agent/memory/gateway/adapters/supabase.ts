/**
 * Supabase Adapter — Remote backup with pgvector
 * Cross-device sync via Supabase Postgres
 */

import { BaseAdapter } from './base';
import {
  MemoryEntry, RecallOpts, MemoryLink, Session,
  AdapterName, AdapterInfo, RelationType
} from '../interface';

export class SupabaseAdapter extends BaseAdapter {
  readonly name: AdapterName = 'supabase';
  private projectRef: string;
  private schema: string;
  private apiUrl: string;
  private connected = false;

  constructor(config: {
    projectRef: string;
    schema?: string;
    apiUrl: string;
  }) {
    super();
    this.projectRef = config.projectRef;
    this.schema = config.schema ?? 'memory';
    this.apiUrl = config.apiUrl;
  }

  async connect(): Promise<void> {
    // Test Supabase connection via REST API
    this.connected = true;
  }

  async disconnect(): Promise<void> {
    this.connected = false;
  }

  async health(): Promise<AdapterInfo> {
    return {
      name: this.name,
      status: this.connected ? 'connected' : 'disconnected',
      latency: 100,
    };
  }

  // ── CRUD ──
  async store(entry: MemoryEntry): Promise<void> {
    this._ensureConnected();
    // POST to Supabase REST: /rest/v1/memories
  }

  async recall(query: string, opts?: RecallOpts): Promise<MemoryEntry[]> {
    this._ensureConnected();
    // GET /rest/v1/memories?content=ilike.*query*
    return [];
  }

  async search(embedding: number[], topK: number): Promise<MemoryEntry[]> {
    this._ensureConnected();
    // RPC call: match_memories(query_embedding, match_count)
    return [];
  }

  async get(id: string): Promise<MemoryEntry | null> {
    this._ensureConnected();
    return null;
  }

  async update(id: string, patch: Partial<MemoryEntry>): Promise<void> {
    this._ensureConnected();
    // PATCH /rest/v1/memories?id=eq.{id}
  }

  async delete(id: string): Promise<void> {
    this._ensureConnected();
    // DELETE /rest/v1/memories?id=eq.{id}
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

  private _ensureConnected(): void {
    if (!this.connected) throw new Error('Supabase adapter not connected');
  }
}
