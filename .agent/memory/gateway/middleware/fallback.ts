/**
 * Fallback Middleware — Try adapters in order, failover transparently
 * Pattern: Design Desk authority model + fallback chain
 */

import { BaseAdapter } from '../adapters/base';
import { AdapterName, AdapterInfo } from '../interface';

export class FallbackController {
  private adapters: Map<AdapterName, BaseAdapter> = new Map();
  private chain: AdapterName[];
  private activeIndex = 0;

  constructor(chain: AdapterName[]) {
    this.chain = chain;
  }

  registerAdapter(adapter: BaseAdapter): void {
    this.adapters.set(adapter.name, adapter);
  }

  get active(): BaseAdapter {
    const name = this.chain[this.activeIndex];
    const adapter = this.adapters.get(name);
    if (!adapter) throw new Error(`Adapter ${name} not registered`);
    return adapter;
  }

  /**
   * Execute an operation with fallback.
   * If active adapter fails, try next in chain.
   */
  async execute<T>(
    operation: (adapter: BaseAdapter) => Promise<T>
  ): Promise<T> {
    for (let i = this.activeIndex; i < this.chain.length; i++) {
      const name = this.chain[i];
      const adapter = this.adapters.get(name);
      if (!adapter) continue;

      try {
        const result = await operation(adapter);
        if (i !== this.activeIndex) {
          console.warn(`[Memory Gateway] Fell back to ${name}`);
        }
        return result;
      } catch (err) {
        console.error(`[Memory Gateway] ${name} failed:`, err);
        if (i === this.chain.length - 1) throw err;
      }
    }
    throw new Error('All adapters failed');
  }

  /**
   * Switch active adapter explicitly
   */
  switchTo(name: AdapterName): void {
    const idx = this.chain.indexOf(name);
    if (idx === -1) throw new Error(`Adapter ${name} not in fallback chain`);
    this.activeIndex = idx;
    console.log(`[Memory Gateway] Switched to ${name}`);
  }

  /**
   * Health check all adapters
   */
  async healthAll(): Promise<AdapterInfo[]> {
    const results: AdapterInfo[] = [];
    for (const [, adapter] of this.adapters) {
      try {
        results.push(await adapter.health());
      } catch {
        results.push({
          name: adapter.name,
          status: 'error',
        });
      }
    }
    return results;
  }

  /**
   * Connect all registered adapters
   */
  async connectAll(): Promise<void> {
    for (const [, adapter] of this.adapters) {
      try {
        await adapter.connect();
      } catch (err) {
        console.warn(`[Memory Gateway] ${adapter.name} connect failed:`, err);
      }
    }
  }
}
