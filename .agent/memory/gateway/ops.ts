/**
 * Memory Operations — Canonical Serialization & ID Generation
 * Pattern: Design Desk deterministic ops + canonical JSON
 */

import { MemoryOp, MemoryOpType, AdapterName, StorePayload, MemoryEntry } from './interface';

// ═══════════════════════════════════════
// Deterministic ID Generation
// ═══════════════════════════════════════

/**
 * Generate a deterministic memory ID from content + context.
 * Same input → same ID (Design Desk pattern: seeded ID factory)
 */
export function generateMemoryId(
  projectId: string | undefined,
  content: string,
  timestamp: string
): string {
  const seed = `${projectId || 'global'}:${content}:${timestamp}`;
  return hashString(seed);
}

/**
 * Simple string hash (FNV-1a variant, hex output)
 */
function hashString(str: string): string {
  let hash = 0x811c9dc5;
  for (let i = 0; i < str.length; i++) {
    hash ^= str.charCodeAt(i);
    hash = (hash * 0x01000193) >>> 0;
  }
  return hash.toString(16).padStart(8, '0') + '-' +
    Date.now().toString(16).padStart(12, '0');
}

// ═══════════════════════════════════════
// Canonical JSON Serialization
// ═══════════════════════════════════════

/**
 * Canonical JSON: sorted keys, stable output.
 * Same object → same string (deterministic, diffable, git-friendly)
 */
export function canonicalJson(obj: unknown): string {
  return JSON.stringify(obj, Object.keys(obj as object).sort(), 2);
}

/**
 * Canonical JSON compact (for ops journal payloads)
 */
export function canonicalJsonCompact(obj: unknown): string {
  if (obj === null || obj === undefined) return JSON.stringify(obj);
  if (typeof obj !== 'object') return JSON.stringify(obj);
  if (Array.isArray(obj)) {
    return '[' + obj.map(canonicalJsonCompact).join(',') + ']';
  }
  const keys = Object.keys(obj).sort();
  const pairs = keys.map(k => `${JSON.stringify(k)}:${canonicalJsonCompact((obj as Record<string, unknown>)[k])}`);
  return '{' + pairs.join(',') + '}';
}

// ═══════════════════════════════════════
// Op Construction Helpers
// ═══════════════════════════════════════

let opSeq = 0;

export function createStoreOp(
  payload: StorePayload,
  adapter: AdapterName,
  sessionId?: string
): MemoryOp {
  return {
    seq: ++opSeq,
    opType: 'store',
    payload: canonicalJsonCompact(payload),
    timestamp: new Date().toISOString(),
    sessionId,
    adapter,
  };
}

export function createUpdateOp(
  id: string,
  patch: Partial<MemoryEntry>,
  adapter: AdapterName,
  sessionId?: string
): MemoryOp {
  return {
    seq: ++opSeq,
    opType: 'update',
    payload: canonicalJsonCompact({ id, patch }),
    timestamp: new Date().toISOString(),
    sessionId,
    adapter,
  };
}

export function createForgetOp(
  id: string,
  reason: string,
  adapter: AdapterName,
  sessionId?: string
): MemoryOp {
  return {
    seq: ++opSeq,
    opType: 'forget',
    payload: canonicalJsonCompact({ id, reason }),
    timestamp: new Date().toISOString(),
    sessionId,
    adapter,
  };
}

export function createLinkOp(
  sourceId: string,
  targetId: string,
  relation: string,
  adapter: AdapterName,
  sessionId?: string
): MemoryOp {
  return {
    seq: ++opSeq,
    opType: 'link',
    payload: canonicalJsonCompact({ sourceId, targetId, relation }),
    timestamp: new Date().toISOString(),
    sessionId,
    adapter,
  };
}

export function createDecayOp(
  affectedIds: string[],
  newScores: Record<string, number>,
  adapter: AdapterName
): MemoryOp {
  return {
    seq: ++opSeq,
    opType: 'decay',
    payload: canonicalJsonCompact({ affectedIds, newScores }),
    timestamp: new Date().toISOString(),
    adapter,
  };
}

/**
 * Reset op sequence counter (for testing/replay)
 */
export function resetOpSeq(value = 0): void {
  opSeq = value;
}
