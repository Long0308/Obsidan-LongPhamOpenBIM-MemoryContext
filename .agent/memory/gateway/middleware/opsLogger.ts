/**
 * Ops Logger Middleware — Append-only journal
 * Pattern: Design Desk ops journal for audit + replay
 */

import { MemoryOp } from '../interface';

export class OpsLogger {
  private journal: MemoryOp[] = [];
  private maxOpsPerSession: number;

  constructor(config: { maxOpsPerSession?: number } = {}) {
    this.maxOpsPerSession = config.maxOpsPerSession ?? 10000;
  }

  /**
   * Log an operation to the journal
   */
  log(op: MemoryOp): void {
    if (this.journal.length >= this.maxOpsPerSession) {
      console.warn('[OpsLogger] Max ops reached, rotating journal');
      this.journal = this.journal.slice(-Math.floor(this.maxOpsPerSession / 2));
    }
    this.journal.push(op);
  }

  /**
   * Get all ops, optionally filtered by session
   */
  getOps(sessionId?: string): MemoryOp[] {
    if (sessionId) {
      return this.journal.filter(op => op.sessionId === sessionId);
    }
    return [...this.journal];
  }

  /**
   * Get ops since a specific sequence number
   */
  getOpsSince(seq: number): MemoryOp[] {
    return this.journal.filter(op => op.seq > seq);
  }

  /**
   * Export journal for persistence
   */
  export(): MemoryOp[] {
    return [...this.journal];
  }

  /**
   * Import journal (for restore/replay)
   */
  import(ops: MemoryOp[]): void {
    this.journal = [...ops];
  }

  /**
   * Clear journal
   */
  clear(): void {
    this.journal = [];
  }

  get length(): number {
    return this.journal.length;
  }
}
