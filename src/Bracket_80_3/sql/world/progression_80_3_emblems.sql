-- WotLK emblem distribution fix (Bracket 80_3 / ToC era)
-- Desired behavior (blizzlike 3.2 / ToC era):
-- - Heroic 5-man dungeon BOSSES: Emblem of Conquest (45624)
-- NOTE: This file focuses on heroic 5-man bosses; higher-tier emblem sources are handled elsewhere.
--
-- Emblem item IDs (WotLK):
-- Heroism 40752
-- Valor   40753
-- Conquest 45624
-- Triumph 47241

-- =====================================================
-- 1) HEROIC 5-MAN DUNGEON BOSSES => CONQUEST (45624)
-- =====================================================
UPDATE `creature_loot_template` cl
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET cl.`Item` = 45624
WHERE cl.`Item` IN (40752, 40753, 47241)
  AND ct.`rank` = 3
  AND EXISTS (
    SELECT 1
    FROM `creature` cr
    JOIN `instance_template` it ON it.`map` = cr.`map`
    WHERE cr.`id1` = cl.`entry`
      AND it.`maxPlayers` = 5
  );

UPDATE `reference_loot_template` rl
JOIN `creature_loot_template` cl ON cl.`Reference` = rl.`Entry`
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET rl.`Item` = 45624
WHERE rl.`Item` IN (40752, 40753, 47241)
  AND ct.`rank` = 3
  AND EXISTS (
    SELECT 1
    FROM `creature` cr
    JOIN `instance_template` it ON it.`map` = cr.`map`
    WHERE cr.`id1` = cl.`entry`
      AND it.`maxPlayers` = 5
  );

-- =====================================================
-- 2) NAXX / EOE / OS BOSSES => TRIUMPH (47241)
-- =====================================================
-- Boss IDs taken from progression_80_2_naxxramas_80_enable.sql
UPDATE `creature_loot_template`
SET `Item` = 47241
WHERE `entry` IN (
    29122,29123,29124,29125,29126,29127,29128,29129,29130,29131,29132,
    28860,27635,
    25038,25040,25041,25042
)
  AND `Item` IN (40752, 40753, 45624);

UPDATE `reference_loot_template` rl
JOIN `creature_loot_template` cl ON cl.`Reference` = rl.`Entry`
SET rl.`Item` = 47241
WHERE cl.`entry` IN (
    29122,29123,29124,29125,29126,29127,29128,29129,29130,29131,29132,
    28860,27635,
    25038,25040,25041,25042
)
  AND rl.`Item` IN (40752, 40753, 45624);

-- =====================================================
-- 3) ULDUAR BOSSES => CONQUEST (45624)
-- =====================================================
-- Keep Ulduar on Conquest in ToC era.
UPDATE `creature_loot_template` cl
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET cl.`Item` = 45624
WHERE cl.`Item` IN (40752, 40753, 47241)
  AND ct.`rank` = 3
  AND EXISTS (
    SELECT 1
    FROM `creature` cr
    WHERE cr.`map` = 603
      AND cr.`id1` = cl.`entry`
  );

UPDATE `reference_loot_template` rl
JOIN `creature_loot_template` cl ON cl.`Reference` = rl.`Entry`
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET rl.`Item` = 45624
WHERE rl.`Item` IN (40752, 40753, 47241)
  AND ct.`rank` = 3
  AND EXISTS (
    SELECT 1
    FROM `creature` cr
    WHERE cr.`map` = 603
      AND cr.`id1` = cl.`entry`
  );
