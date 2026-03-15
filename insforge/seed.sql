-- Insert entities
INSERT INTO entities (name, type, description, properties) VALUES
('Agent Swarm', 'project', 'AI Agent Swarm system with 56 skills', '{"skills": 56, "plugins": 15}'::jsonb),
('Insforge', 'tool', 'Backend-as-a-Service platform', '{"region": "ap-southeast"}'::jsonb),
('Memory Gateway', 'concept', '3-layer memory system: insforge/supabase/sqlite', '{"adapters": 3}'::jsonb),
('Obsidian', 'tool', 'Knowledge management vault', '{"vault": "LPOpenBIMAI"}'::jsonb),
('Supabase', 'tool', 'Remote sync backup adapter', '{"role": "backup"}'::jsonb),
('SQLite', 'tool', 'Local offline fallback adapter', '{"role": "fallback"}'::jsonb);

-- Insert more memories
INSERT INTO memories (type, category, content, tags, importance, source, project_id, session_id) VALUES
('long-term', 'tech-stack', 'Insforge (primary) + Supabase (sync) + SQLite (offline) — fallback chain for Memory Gateway', ARRAY['tech-stack','infrastructure'], 0.95, 'agent', 'LPOpenBIMAI', '2026-03-15'),
('long-term', 'preferences', 'User prefers Vietnamese responses, English code. Uses Obsidian as knowledge hub. Vault: LPOpenBIMAI', ARRAY['preferences','language','obsidian'], 0.85, 'agent', 'LPOpenBIMAI', '2026-03-15'),
('long-term', 'patterns', '15 Obsidian plugins installed. Graph viz: 3D Graph, Graphs, Graphviz, Graph Analysis. Editing: Smart Typography, Advanced Cursors, Autocorrect', ARRAY['plugins','obsidian','patterns'], 0.8, 'agent', 'LPOpenBIMAI', '2026-03-15'),
('short-term', 'session', 'E2E test results: 9/9 pass. All systems operational. Insforge agent linked and skills installed.', ARRAY['test','e2e','verification'], 0.7, 'agent', 'LPOpenBIMAI', '2026-03-15');
