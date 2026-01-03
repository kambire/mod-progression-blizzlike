-- Hide emblem vendors until their brackets. GMs (phase debug) can still see phased NPCs.
-- NPCs:
-- 31581 (Alianza, Heroísmo/Valor)
-- 31582 (Horda, Heroísmo/Valor)
-- 33963 (Conquista/Ulduar)
-- 35495 (Triunfo/ToC)
-- 37941 (Escarcha/ICC)

START TRANSACTION;

-- Backup spawns
DROP TABLE IF EXISTS backupKambi_creature_phase_emblems_hide_7174;
CREATE TABLE backupKambi_creature_phase_emblems_hide_7174 LIKE creature;
INSERT INTO backupKambi_creature_phase_emblems_hide_7174
SELECT * FROM creature WHERE id1 IN (31581,31582,33963,35495,37941);

-- Set high phase mask to hide from players (GMs typically bypass phase)
UPDATE creature
SET phaseMask = 64
WHERE id1 IN (31581,31582,33963,35495,37941);

COMMIT;
