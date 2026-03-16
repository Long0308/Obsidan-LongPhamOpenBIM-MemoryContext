import{createClient}from'npm:@insforge/sdk';
const H={'Access-Control-Allow-Origin':'*','Access-Control-Allow-Methods':'GET,POST,OPTIONS','Access-Control-Allow-Headers':'Content-Type,Authorization'};
const j=(d:unknown,s=200)=>new Response(JSON.stringify(d),{status:s,headers:{...H,'Content-Type':'application/json'}});

async function gp(p:string,c:string){const t=Deno.env.get('GITHUB_PAT')!,u=`https://api.github.com/repos/${Deno.env.get('GITHUB_OWNER')||'Long0308'}/${Deno.env.get('GITHUB_REPO')||'Obsidan-LongPhamOpenBIM-MemoryContext'}/contents/${p}`,h={Authorization:`Bearer ${t}`,Accept:'application/vnd.github+json'};let s:string|undefined;try{const r=await fetch(u,{headers:h});if(r.ok)s=(await r.json()).sha}catch(_){}return(await fetch(u,{method:'PUT',headers:{...h,'Content-Type':'application/json'},body:JSON.stringify({message:`auto: ${p}`,content:btoa(unescape(encodeURIComponent(c))),...(s?{sha:s}:{})})})).ok?'ok':'fail'}

export default async function(req:Request):Promise<Response>{
if(req.method==='OPTIONS')return new Response(null,{status:204,headers:H});
const u=new URL(req.url),p=u.pathname.split('/').filter(Boolean).pop()||'',db=createClient({baseUrl:Deno.env.get('INSFORGE_BASE_URL'),anonKey:Deno.env.get('ANON_KEY')}).database;
try{

// ── Health ──
if(req.method==='GET'&&(!p||p==='health')){const[m,e,s]=await Promise.all([db.from('memories').select('id',{count:'exact',head:true}),db.from('entities').select('id',{count:'exact',head:true}),db.from('sync_log').select('id',{count:'exact',head:true})]);return j({status:'ok',v:'2.4',counts:{memories:m.count||0,entities:e.count||0,sync:s.count||0}})}

// ── Init Session ──
if(req.method==='POST'&&p==='init-session'){const b=await req.json();const proj=b.project||'LPOpenBIMAI';
  // Persist context state to DB (survives cold starts)
  await db.from('context_state').upsert({
    project:proj, pct:2, est_tokens:2000, model_limit:200000,
    session_start:new Date().toISOString(), last_checkpoint:'None',
    conversation_id:b.conversation_id||'', model:b.model||'', ide:b.ide||'',
    breakdown:{chat:0,files:0,system:2000,tools:0},
    updated_at:new Date().toISOString()
  },{onConflict:'project'});
  const{data:m,error:e}=await db.from('memories').insert([{type:'long-term',category:'session-init',content:`Conv ${(b.conversation_id||'').substring(0,8)}: init ${new Date().toISOString()}`,tags:['session-init',b.ide,proj].filter(Boolean),importance:0.3,source:'auto-memory'}]).select();
  return e?j({error:e.message},500):j({status:'ok',id:m?.[0]?.id,cid:b.conversation_id})}

// ── Context Update (agent POSTs real context data — persisted to DB) ──
if(req.method==='POST'&&p==='context-update'){const b=await req.json();const proj=b.project||'LPOpenBIMAI';
  // Read existing state for merge
  const{data:existing}=await db.from('context_state').select('*').eq('project',proj).single();
  const state={
    project:proj,
    pct:b.context_percent||0,
    est_tokens:b.est_tokens||0,
    model_limit:b.model_limit||200000,
    session_start:existing?.session_start||new Date().toISOString(),
    last_checkpoint:b.checkpoint||new Date().toISOString(),
    conversation_id:b.conversation_id||existing?.conversation_id||'',
    model:b.model||existing?.model||'',
    ide:b.ide||existing?.ide||'',
    breakdown:b.breakdown||existing?.breakdown||{},
    updated_at:new Date().toISOString()
  };
  await db.from('context_state').upsert(state,{onConflict:'project'});
  return j({status:'ok',pct:state.pct,est_tokens:state.est_tokens})}

// ── Context Status (dashboard polls this — reads from DB) ──
if(req.method==='GET'&&p==='context-status'){const proj=u.searchParams.get('project')||'LPOpenBIMAI';
  const{data:state}=await db.from('context_state').select('*').eq('project',proj).single();
  if(!state)return j({active:false,pct:0,est_tokens:0,model_limit:200000,session_start:null,last_checkpoint:'None',breakdown:{},conversation_id:'',model:'',ide:''});
  return j({active:true,pct:state.pct,est_tokens:state.est_tokens,model_limit:state.model_limit,session_start:state.session_start,last_checkpoint:state.last_checkpoint,conversation_id:state.conversation_id,model:state.model,ide:state.ide,breakdown:state.breakdown||{}})}

// ── Save Session ──
if(req.method==='POST'&&p==='save-session'){const b=await req.json();const{data:m,error:e}=await db.from('memories').insert([{type:'long-term',category:'session',content:(b.content||'').substring(0,5000),tags:['session',b.ide,b.project].filter(Boolean),importance:0.9,source:'auto-memory'}]).select();if(e)return j({error:e.message},500);if(b.decisions?.length)await db.from('memories').insert(b.decisions.map((d:string)=>({type:'long-term',category:'decisions',content:d,tags:['decision',b.project].filter(Boolean),importance:0.85,source:'auto-memory'})));const g=b.push_github&&Deno.env.get('GITHUB_PAT')?await gp(`sessions/s-${m?.[0]?.id}.md`,b.content||''):null;await db.from('sync_log').insert([{operation:'save',table_name:'memories',adapter_source:b.ide||'auto',adapter_target:b.push_github?'gh+if':'if',status:'success'}]);return j({status:'saved',id:m?.[0]?.id,gh:g})}

// ── List Sessions ──
if(req.method==='GET'&&p==='sessions'){const pr=u.searchParams.get('project');let q=db.from('memories').select('*').in('category',['session','session-init']).order('created_at',{ascending:false}).limit(20);if(pr)q=q.contains('tags',[pr]);const{data:d,error:e}=await q;return e?j({error:e.message},500):j({sessions:d,count:d?.length||0})}

// ── Context Stats ──
if(req.method==='GET'&&p==='context-stats'){
  const[m,e,sl]=await Promise.all([db.from('memories').select('id',{count:'exact',head:true}),db.from('entities').select('id',{count:'exact',head:true}),db.from('sync_log').select('*').order('created_at',{ascending:false}).limit(10)]);
  return j({stats:{memories:m.count||0,entities:e.count||0},recent_syncs:sl.data||[]})}

// ── Quotas GET ──
if(req.method==='GET'&&p==='quotas'){const{data:d,error:e}=await db.from('model_quotas').select('*').eq('project',u.searchParams.get('project')||'LPOpenBIMAI').order('model_name');return e?j({error:e.message},500):j({quotas:d||[]})}

// ── Quotas POST ──
if(req.method==='POST'&&p==='quotas'){const{quotas:i,project:pr}=await req.json();if(!i?.length)return j({error:'need quotas'},400);const r:any[]=[];for(const q of i){const{data:d,error:e}=await db.from('model_quotas').upsert({model_name:q.model_name,tier:q.tier||'',usage_pct:q.usage_pct,reset_at:q.reset_at||null,updated_by:'agent',project:pr||'LPOpenBIMAI',updated_at:new Date().toISOString()},{onConflict:'model_name,tier'}).select();r.push(e?{m:q.model_name,e:e.message}:{m:q.model_name,id:d?.[0]?.id})}return j({status:'ok',r})}

// ── Sync GitHub ──
if(req.method==='POST'&&p==='sync-github'){if(!Deno.env.get('GITHUB_PAT'))return j({error:'No PAT'},500);
  const{data:ss}=await db.from('memories').select('*').in('category',['session','session-init']).order('created_at',{ascending:false}).limit(5);
  const r:any[]=[];
  for(const s of(ss||[])){const f=`sessions/s-${s.id}.md`;r.push({id:s.id,s:await gp(f,s.content||JSON.stringify(s))})}
  // Also sync context state from DB
  const{data:ctxRows}=await db.from('context_state').select('*');
  const ctxSnap=JSON.stringify(ctxRows||[],null,2);
  const ctxResult=await gp('sessions/context-state.json',ctxSnap);
  await db.from('sync_log').insert([{operation:'sync-gh',table_name:'memories',adapter_source:'dash',adapter_target:'gh',status:'success'}]);
  return j({status:'synced',snap:new Date().toISOString().substring(0,19),n:r.length,files:r,ctx:ctxResult})}

return j({error:'404'},404);
}catch(e){return j({error:(e as Error).message},500)}}
