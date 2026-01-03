-- Unhide Frost emblem vendor at ICC bracket (80_4_1).
-- NPC: 37941 (Emblema de Escarcha)

START TRANSACTION;

UPDATE creature
SET phaseMask = 1
WHERE id1 = 37941;

COMMIT;
