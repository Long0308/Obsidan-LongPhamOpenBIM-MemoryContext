-- model_quotas table for live quota tracking
CREATE TABLE IF NOT EXISTS model_quotas (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  model_name TEXT NOT NULL,
  tier TEXT DEFAULT '',
  usage_pct REAL NOT NULL CHECK (usage_pct >= 0 AND usage_pct <= 100),
  reset_at TIMESTAMPTZ,
  updated_by TEXT DEFAULT 'agent',
  project TEXT DEFAULT 'LPOpenBIMAI',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(model_name, tier)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_quotas_model ON model_quotas(model_name);
CREATE INDEX IF NOT EXISTS idx_quotas_project ON model_quotas(project);

-- RLS
ALTER TABLE model_quotas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read_quotas" ON model_quotas FOR SELECT USING (true);
CREATE POLICY "service_all_quotas" ON model_quotas FOR ALL USING (true) WITH CHECK (true);

-- Updated_at trigger
CREATE TRIGGER quotas_updated_at
  BEFORE UPDATE ON model_quotas
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
