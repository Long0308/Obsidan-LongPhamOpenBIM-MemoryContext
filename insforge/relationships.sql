-- Create relationships between entities
-- First get entity IDs
INSERT INTO relationships (source_id, target_id, relation_type, strength, metadata)
SELECT s.id, t.id, 'uses', 0.95, '{"context": "primary backend"}'::jsonb
FROM entities s, entities t WHERE s.name = 'Agent Swarm' AND t.name = 'Insforge';

INSERT INTO relationships (source_id, target_id, relation_type, strength, metadata)
SELECT s.id, t.id, 'uses', 0.9, '{"context": "knowledge hub"}'::jsonb
FROM entities s, entities t WHERE s.name = 'Agent Swarm' AND t.name = 'Obsidian';

INSERT INTO relationships (source_id, target_id, relation_type, strength, metadata)
SELECT s.id, t.id, 'contains', 1.0, '{"context": "core component"}'::jsonb
FROM entities s, entities t WHERE s.name = 'Agent Swarm' AND t.name = 'Memory Gateway';

INSERT INTO relationships (source_id, target_id, relation_type, strength, metadata)
SELECT s.id, t.id, 'connects_to', 0.95, '{"role": "primary adapter"}'::jsonb
FROM entities s, entities t WHERE s.name = 'Memory Gateway' AND t.name = 'Insforge';

INSERT INTO relationships (source_id, target_id, relation_type, strength, metadata)
SELECT s.id, t.id, 'connects_to', 0.8, '{"role": "sync backup"}'::jsonb
FROM entities s, entities t WHERE s.name = 'Memory Gateway' AND t.name = 'Supabase';

INSERT INTO relationships (source_id, target_id, relation_type, strength, metadata)
SELECT s.id, t.id, 'connects_to', 0.7, '{"role": "offline fallback"}'::jsonb
FROM entities s, entities t WHERE s.name = 'Memory Gateway' AND t.name = 'SQLite';
