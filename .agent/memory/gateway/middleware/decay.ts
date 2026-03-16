/**
 * Decay Manager — Self-evolving memory
 * Pattern: Design Desk performance guardrails + Obsidian self-evolving skill
 * 
 * Memories lose relevance over time if not accessed.
 * Decay score: 1.0 (fresh) → 0.0 (archived)
 */

import { BaseAdapter } from '../adapters/base';
import { MemoryEntry } from '../interface';

export interface DecayConfig {
  /** Decay score threshold for archiving (default: 0.1) */
  threshold: number;
  /** Days of inactivity before decay starts (default: 30) */
  inactiveDays: number;
  /** Check interval description (default: '1h') */
  checkInterval: string;
}

export class DecayManager {
  private config: DecayConfig;

  constructor(config: Partial<DecayConfig> = {}) {
    this.config = {
      threshold: config.threshold ?? 0.1,
      inactiveDays: config.inactiveDays ?? 30,
      checkInterval: config.checkInterval ?? '1h',
    };
  }

  /**
   * Calculate new decay score based on access patterns
   * Formula: score = baseDecay * accessBoost * recencyBoost
   */
  calculateDecay(entry: MemoryEntry): number {
    const now = Date.now();
    const lastAccessed = new Date(entry.lastAccessed).getTime();
    const daysSinceAccess = (now - lastAccessed) / (1000 * 60 * 60 * 24);

    // Base decay: linear decrease over inactiveDays
    const baseDecay = Math.max(0, 1 - (daysSinceAccess / (this.config.inactiveDays * 2)));

    // Access boost: more access = slower decay
    const accessBoost = Math.min(2, 1 + Math.log10(entry.accessCount + 1) * 0.3);

    // Type boost: decisions and patterns decay slower
    const typeBoost = ['decision', 'pattern', 'preference'].includes(entry.type) ? 1.3 : 1.0;

    return Math.min(1.0, baseDecay * accessBoost * typeBoost);
  }

  /**
   * Run decay pass on all memories
   * Returns IDs that should be archived
   */
  async runDecayPass(adapter: BaseAdapter): Promise<string[]> {
    const allMemories = await adapter.getAllMemories({ minDecay: 0 });
    const toArchive: string[] = [];

    for (const entry of allMemories) {
      const newScore = this.calculateDecay(entry);

      if (newScore !== entry.decayScore) {
        await adapter.update(entry.id, { decayScore: newScore });
      }

      if (newScore < this.config.threshold) {
        toArchive.push(entry.id);
        await adapter.update(entry.id, {
          archivedAt: new Date().toISOString(),
        });
      }
    }

    if (toArchive.length > 0) {
      console.log(`[Decay] Archived ${toArchive.length} memories below threshold ${this.config.threshold}`);
    }

    return toArchive;
  }

  /**
   * Check if a memory should be excluded from recalls
   */
  shouldExclude(entry: MemoryEntry): boolean {
    return entry.decayScore < this.config.threshold || !!entry.archivedAt;
  }
}
