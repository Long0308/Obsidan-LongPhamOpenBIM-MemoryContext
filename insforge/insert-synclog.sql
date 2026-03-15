INSERT INTO sync_log (operation, table_name, adapter_source, adapter_target, status, source, target, details) VALUES
('push', 'memories', 'obsidian', 'insforge', 'success', 'manual', 'insforge', '{"action": "initial seed", "tables": "memories,entities,relationships", "rows": 17}'::jsonb),
('push', 'session-note', 'obsidian', 'github', 'success', 'manual', 'github', '{"file": "session-2026-03-15-antigravity-LPOpenBIMAI.md", "repo": "Long0308/Obsidan-LongPhamOpenBIM-MemoryContext"}'::jsonb),
('sync', 'memories', 'agent', 'insforge', 'success', 'auto-memory', 'insforge', '{"session": "2026-03-15", "ide": "antigravity", "project": "LPOpenBIMAI"}'::jsonb);
