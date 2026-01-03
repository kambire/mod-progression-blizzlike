-- Unhide Conquest emblem vendor at Ulduar bracket (80_2_2).
-- NPC: 33963 (Conquista/Ulduar vendor)

START TRANSACTION;

UPDATE creature
SET phaseMask = 1
WHERE id1 = 33963;

COMMIT;
