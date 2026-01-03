-- Unhide Triumph emblem vendor at ToC bracket (80_3).
-- NPC: 35495 (Triunfo/ToC vendor)

START TRANSACTION;

UPDATE creature
SET phaseMask = 1
WHERE id1 = 35495;

COMMIT;
