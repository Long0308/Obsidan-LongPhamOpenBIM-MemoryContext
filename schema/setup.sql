-- Auto-Memory Kit — Database Schema
-- Run ONCE on your InsForge project
-- Usage: paste into InsForge SQL Editor or insforge db query

-- ============================================
-- TABLE: memories
-- ============================================
CREATE TABLE IF NOT EXISTS memories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  type TEXT NOT NULL DEFAULT 'short-term',
  category TEXT NOT NULL DEFAULT 'general',
  content TEXT NOT NULL,
  tags TEXT[] DEFAULT '{}',
  importance NUMERIC(3,2) DEFAULT 0.5,
  source TEXT DEFAULT 'manual',
  expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- TABLE: entities
-- ============================================
CREATE TABLE IF NOT EXISTS entities (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  type TEXT NOT NULL,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- TABLE: relationships
-- ============================================
CREATE TABLE IF NOT EXISTS relationships (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  source_entity_id UUID REFERENCES entities(id),
  target_entity_id UUID REFERENCES entities(id),
  relationship_type TEXT NOT NULL,
  weight NUMERIC(3,2) DEFAULT 0.5,
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- TABLE: sync_log
-- ============================================
CREATE TABLE IF NOT EXISTS sync_log (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  operation TEXT NOT NULL,
  table_name TEXT NOT NULL,
  record_id UUID,
  adapter_source TEXT NOT NULL,
  adapter_target TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending',
  error_message TEXT,
  source TEXT,
  target TEXT,
  details JSONB,
  synced_at TIMESTAMPTZ DEFAULT now(),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- CONSTRAINTS
-- ============================================
ALTER TABLE sync_log ADD CONSTRAINT sync_log_operation_check
  CHECK (operation = ANY(ARRAY['create','update','delete','sync','save-session','cron-sync']));
ALTER TABLE sync_log ADD CONSTRAINT sync_log_status_check
  CHECK (status = ANY(ARRAY['pending','success','failed']));

-- ============================================
-- ROW LEVEL SECURITY
-- ============================================
ALTER TABLE memories ENABLE ROW LEVEL SECURITY;
ALTER TABLE entities ENABLE ROW LEVEL SECURITY;
ALTER TABLE relationships ENABLE ROW LEVEL SECURITY;
ALTER TABLE sync_log ENABLE ROW LEVEL SECURITY;

-- GRANTS (critical — without this, inserts fail silently!)
GRANT SELECT, INSERT, UPDATE ON memories TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE ON entities TO anon, authenticated;
GRANT SELECT, INSERT, UPDATE ON relationships TO anon, authenticated;
GRANT SELECT, INSERT ON sync_log TO anon, authenticated;

-- RLS POLICIES
CREATE POLICY "public_all" ON memories FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_all" ON entities FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_all" ON relationships FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_all" ON sync_log FOR ALL USING (true) WITH CHECK (true);

-- ============================================
-- INDEXES
-- ============================================
CREATE INDEX IF NOT EXISTS idx_memories_category ON memories(category);
CREATE INDEX IF NOT EXISTS idx_memories_tags ON memories USING GIN(tags);
CREATE INDEX IF NOT EXISTS idx_memories_type ON memories(type);
CREATE INDEX IF NOT EXISTS idx_memories_source ON memories(source);
CREATE INDEX IF NOT EXISTS idx_memories_created ON memories(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_entities_type ON entities(type);
CREATE INDEX IF NOT EXISTS idx_entities_name ON entities(name);
CREATE INDEX IF NOT EXISTS idx_relationships_source ON relationships(source_entity_id);
CREATE INDEX IF NOT EXISTS idx_relationships_target ON relationships(target_entity_id);
CREATE INDEX IF NOT EXISTS idx_sync_log_status ON sync_log(status);
CREATE INDEX IF NOT EXISTS idx_sync_log_operation ON sync_log(operation);
CREATE INDEX IF NOT EXISTS idx_sync_log_created ON sync_log(created_at DESC);
