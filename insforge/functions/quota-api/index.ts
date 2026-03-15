import { createClient } from 'npm:@insforge/sdk';
const H = { 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Methods': 'GET, POST, OPTIONS', 'Access-Control-Allow-Headers': 'Content-Type, Authorization' };
const j = (d: unknown, s = 200) => new Response(JSON.stringify(d), { status: s, headers: { ...H, 'Content-Type': 'application/json' } });
export default async function (req: Request): Promise<Response> {
  if (req.method === 'OPTIONS') return new Response(null, { status: 204, headers: H });
  const url = new URL(req.url), p = url.pathname.split('/').filter(Boolean).pop() || '';
  const db = createClient({ baseUrl: Deno.env.get('INSFORGE_BASE_URL'), anonKey: Deno.env.get('ANON_KEY') }).database;
  try {
    if (req.method === 'GET' && (!p || p === 'health' || p === 'quota-api')) {
      return j({ status: 'ok', v: '1.0' });
    }
    if (req.method === 'GET' && p === 'quotas') {
      const pr = url.searchParams.get('project') || 'LPOpenBIMAI';
      const { data, error } = await db.from('model_quotas').select('*').eq('project', pr).order('model_name');
      if (error) return j({ error: error.message }, 500);
      return j({ quotas: data || [], count: data?.length || 0 });
    }
    if (req.method === 'POST' && p === 'quotas') {
      const { quotas: items, project } = await req.json();
      if (!items?.length) return j({ error: 'quotas[] required' }, 400);
      const rs = [];
      for (const q of items) {
        const { data, error } = await db.from('model_quotas').upsert({
          model_name: q.model_name, tier: q.tier || '', usage_pct: q.usage_pct,
          reset_at: q.reset_at || null, updated_by: 'agent',
          project: project || 'LPOpenBIMAI', updated_at: new Date().toISOString()
        }, { onConflict: 'model_name,tier' }).select();
        rs.push(error ? { model: q.model_name, error: error.message } : { model: q.model_name, id: data?.[0]?.id });
      }
      return j({ status: 'updated', results: rs, count: rs.length });
    }
    return j({ error: 'Not found', routes: ['health', 'quotas'] }, 404);
  } catch (err) { return j({ error: (err as Error).message }, 500); }
}
