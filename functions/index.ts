import { createClient } from 'npm:@insforge/sdk';
const H = { 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Methods': 'GET, POST, OPTIONS', 'Access-Control-Allow-Headers': 'Content-Type, Authorization' };
const j = (d: unknown, s = 200) => new Response(JSON.stringify(d), { status: s, headers: { ...H, 'Content-Type': 'application/json' } });
async function ghPush(path: string, content: string) {
  const t = Deno.env.get('GITHUB_PAT')!, o = Deno.env.get('GITHUB_OWNER') || 'Long0308', rp = Deno.env.get('GITHUB_REPO') || 'Obsidan-LongPhamOpenBIM-MemoryContext';
  const u = `https://api.github.com/repos/${o}/${rp}/contents/${path}`, h = { Authorization: `Bearer ${t}`, Accept: 'application/vnd.github+json' };
  let sha: string | undefined;
  try { const r = await fetch(u, { headers: h }); if (r.ok) sha = (await r.json()).sha; } catch (_) {}
  const r = await fetch(u, { method: 'PUT', headers: { ...h, 'Content-Type': 'application/json' }, body: JSON.stringify({ message: `auto: ${path}`, content: btoa(unescape(encodeURIComponent(content))), ...(sha ? { sha } : {}) }) });
  return r.ok ? 'pushed' : `failed:${r.status}`;
}
export default async function (req: Request): Promise<Response> {
  if (req.method === 'OPTIONS') return new Response(null, { status: 204, headers: H });
  const url = new URL(req.url), p = url.pathname.split('/').filter(Boolean).pop() || '';
  const db = createClient({ baseUrl: Deno.env.get('INSFORGE_BASE_URL'), anonKey: Deno.env.get('ANON_KEY') }).database;
  try {
    if (req.method === 'GET' && (!p || p === 'health' || p === 'memory-gateway')) {
      const [m, e, s] = await Promise.all([db.from('memories').select('id', { count: 'exact', head: true }), db.from('entities').select('id', { count: 'exact', head: true }), db.from('sync_log').select('id', { count: 'exact', head: true })]);
      return j({ status: 'ok', v: '2.0', counts: { memories: m.count || 0, entities: e.count || 0, sync_log: s.count || 0 } });
    }
    if (req.method === 'POST' && p === 'save-session') {
      const { session_id, ide, project, content, decisions, push_github } = await req.json();
      const { data: mem, error } = await db.from('memories').insert([{ type: 'long-term', category: 'session', content: (content || '').substring(0, 5000), tags: ['session', ide, project].filter(Boolean), importance: 0.9, source: 'auto-memory' }]).select();
      if (error) return j({ error: error.message }, 500);
      if (decisions?.length) await db.from('memories').insert(decisions.map((d: string) => ({ type: 'long-term', category: 'decisions', content: d, tags: ['decision', project].filter(Boolean), importance: 0.85, source: 'auto-memory' })));
      const gh = push_github && Deno.env.get('GITHUB_PAT') ? await ghPush(`sessions/session-${session_id}-${ide}-${project}.md`, content || '') : null;
      await db.from('sync_log').insert([{ operation: 'save-session', table_name: 'memories', adapter_source: ide || 'auto', adapter_target: push_github ? 'github+insforge' : 'insforge', status: 'success' }]);
      return j({ status: 'saved', memory_id: mem?.[0]?.id, github: gh, session_id });
    }
    if (req.method === 'GET' && p === 'sessions') {
      const pr = url.searchParams.get('project');
      let q = db.from('memories').select('*').eq('category', 'session').order('created_at', { ascending: false }).limit(20);
      if (pr) q = q.contains('tags', [pr]);
      const { data, error } = await q;
      return error ? j({ error: error.message }, 500) : j({ sessions: data, count: data?.length || 0 });
    }
    if (req.method === 'GET' && p === 'context-stats') {
      const [m, e] = await Promise.all([db.from('memories').select('id', { count: 'exact', head: true }), db.from('entities').select('id', { count: 'exact', head: true })]);
      const { data: sl } = await db.from('sync_log').select('*').order('created_at', { ascending: false }).limit(5);
      return j({ stats: { memories: m.count || 0, entities: e.count || 0 }, recent_syncs: sl });
    }
    if (req.method === 'POST' && p === 'sync-github') {
      if (!Deno.env.get('GITHUB_PAT')) return j({ error: 'GITHUB_PAT not set' }, 500);
      const { data } = await db.from('memories').select('*').order('created_at', { ascending: false }).limit(50);
      const fn = `snapshot-${new Date().toISOString().split('T')[0]}.json`;
      const gh = await ghPush(`context-snapshots/${fn}`, JSON.stringify({ timestamp: new Date().toISOString(), count: data?.length || 0, data }, null, 2));
      await db.from('sync_log').insert([{ operation: 'cron-sync', table_name: 'memories', adapter_source: 'insforge', adapter_target: 'github', status: gh === 'pushed' ? 'success' : 'failed' }]);
      return j({ status: gh === 'pushed' ? 'synced' : 'failed', snapshot: fn });
    }
    return j({ error: 'Not found', routes: ['health', 'save-session', 'sessions', 'context-stats', 'sync-github'] }, 404);
  } catch (err) { return j({ error: (err as Error).message }, 500); }
}
