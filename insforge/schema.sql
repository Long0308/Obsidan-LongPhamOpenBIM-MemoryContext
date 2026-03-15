-- =============================================
-- Memory Gateway Schema for LongPhamOpenBIM-MemoryContext
-- =============================================

-- 1. MEMORIES TABLE
CREATE TABLE memories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  type TEXT NOT NULL CHECK (type IN ('short-term', 'long-term', 'project', 'archived')),
  category TEXT NOT NULL DEFAULT 'general',
  content TEXT NOT NULL,
  tags TEXT[] DEFAULT '{}',
  metadata JSONB DEFAULT '{}',
  importance REAL DEFAULT 0.5 CHECK (importance >= 0 AND importance <= 1),
  decay_rate REAL DEFAULT 0.01 CHECK (decay_rate >= 0 AND decay_rate <= 1),
  last_accessed TIMESTAMPTZ DEFAULT now(),
  access_count INTEGER DEFAULT 0,
  source TEXT DEFAULT 'agent',
  project_id TEXT,
  session_id TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 2. ENTITIES TABLE (knowledge graph nodes)
CREATE TABLE entities (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('person', 'tool', 'project', 'concept', 'skill', 'pattern')),
  description TEXT,
  properties JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(name, type)
);

-- 3. RELATIONSHIPS TABLE (knowledge graph edges)
CREATE TABLE relationships (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  source_id UUID NOT NULL REFERENCES entities(id) ON DELETE CASCADE,
  target_id UUID NOT NULL REFERENCES entities(id) ON DELETE CASCADE,
  relation_type TEXT NOT NULL,
  strength REAL DEFAULT 1.0 CHECK (strength >= 0 AND strength <= 1),
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(source_id, target_id, relation_type)
);

-- 4. SYNC_LOG TABLE (tracks sync between adapters)
CREATE TABLE sync_log (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  operation TEXT NOT NULL CHECK (operation IN ('create', 'update', 'delete', 'sync')),
  table_name TEXT NOT NULL,
  record_id UUID NOT NULL,
  adapter_source TEXT NOT NULL,
  adapter_target TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'success', 'failed')),
  error_message TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 5. INDEXES
CREATE INDEX idx_memories_type ON memories(type);
CREATE INDEX idx_memories_category ON memories(category);
CREATE INDEX idx_memories_tags ON memories USING GIN(tags);
CREATE INDEX idx_memories_project ON memories(project_id);
CREATE INDEX idx_memories_session ON memories(session_id);
CREATE INDEX idx_memories_importance ON memories(importance DESC);
CREATE INDEX idx_memories_last_accessed ON memories(last_accessed DESC);
CREATE INDEX idx_memories_created ON memories(created_at DESC);
CREATE INDEX idx_entities_type ON entities(type);
CREATE INDEX idx_entities_name ON entities(name);
CREATE INDEX idx_relationships_source ON relationships(source_id);
CREATE INDEX idx_relationships_target ON relationships(target_id);
CREATE INDEX idx_sync_log_status ON sync_log(status);

-- 6. ROW LEVEL SECURITY
ALTER TABLE memories ENABLE ROW LEVEL SECURITY;
ALTER TABLE entities ENABLE ROW LEVEL SECURITY;
ALTER TABLE relationships ENABLE ROW LEVEL SECURITY;
ALTER TABLE sync_log ENABLE ROW LEVEL SECURITY;

-- Public read for all tables (agent needs access)
CREATE POLICY "public_read_memories" ON memories FOR SELECT USING (true);
CREATE POLICY "public_read_entities" ON entities FOR SELECT USING (true);
CREATE POLICY "public_read_relationships" ON relationships FOR SELECT USING (true);
CREATE POLICY "public_read_sync_log" ON sync_log FOR SELECT USING (true);

-- Service role can do everything
CREATE POLICY "service_all_memories" ON memories FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "service_all_entities" ON entities FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "service_all_relationships" ON relationships FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "service_all_sync_log" ON sync_log FOR ALL USING (true) WITH CHECK (true);

-- 7. UPDATED_AT TRIGGER
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER memories_updated_at
  BEFORE UPDATE ON memories
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER entities_updated_at
  BEFORE UPDATE ON entities
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
