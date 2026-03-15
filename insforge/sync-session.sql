INSERT INTO memories (type, category, content, tags, importance, source, project_id, session_id) VALUES
('long-term', 'session', 'Phase 3-6: Created 20 agent notes, expanded skills 21 to 47, created 15 plugin notes, auto-configured graph.json with 6 color groups. Total 93 tagged notes.', ARRAY['session','agents','graph-coloring'], 0.9, 'agent', 'LPOpenBIMAI', '2026-03-15'),
('long-term', 'patterns', 'Session naming: session-DATE-IDE-PROJECT.md. IDEs: antigravity, codex, claude, cursor, gemini.', ARRAY['naming','convention'], 0.85, 'agent', 'LPOpenBIMAI', '2026-03-15'),
('long-term', 'patterns', 'Auto-memory NOT yet implemented. Need end-of-session hook and edge function trigger.', ARRAY['auto-memory','todo'], 0.95, 'agent', 'LPOpenBIMAI', '2026-03-15');

INSERT INTO entities (name, type, description, properties) VALUES
('Agent-Agents', 'folder', '20 agent notes in Obsidian', '{"count": 20}'::jsonb),
('Agent-Plugins', 'folder', '15 plugin notes in Obsidian', '{"count": 15}'::jsonb);
