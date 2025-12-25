-- WotLK emblem distribution fix (Bracket 80_2 / Ulduar era)
-- Desired behavior (as requested):
-- - Heroic 5-man dungeon BOSSES: Emblem of Heroism (40752)
-- - Naxxramas 80, Eye of Eternity, Obsidian Sanctum BOSSES: Emblem of Valor (40753)
-- - Ulduar BOSSES: Emblem of Conquest (45624)
-- - RDF/LFG random heroic reward: Valor (handled via quests/lfg_dungeon_rewards in 80_1_1)
--
-- Emblem item IDs (WotLK):
-- Heroism 40752
-- Valor   40753
-- Conquest 45624
-- Triumph 47241
-- Frost   49426

-- =====================================================
-- 1) HEROIC 5-MAN DUNGEON BOSSES => HEROISM (40752)
-- =====================================================
UPDATE `creature_loot_template` cl
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET cl.`Item` = 40752
WHERE cl.`Item` IN (47241, 40753, 45624)
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
SET rl.`Item` = 40752
WHERE rl.`Item` IN (47241, 40753, 45624)
  AND ct.`rank` = 3
  AND EXISTS (
    SELECT 1
    FROM `creature` cr
    JOIN `instance_template` it ON it.`map` = cr.`map`
    WHERE cr.`id1` = cl.`entry`
      AND it.`maxPlayers` = 5
  );

-- =====================================================
-- 2) NAXX / EOE / OS BOSSES => VALOR (40753)
-- =====================================================
-- Boss IDs taken from progression_80_2_naxxramas_80_enable.sql
SET @NAXX_EOE_OS_BOSSES := '29122,29123,29124,29125,29126,29127,29128,29129,29130,29131,29132,28860,27635,25038,25040,25041,25042';

-- NOTE: MySQL can't use a CSV string directly in IN().
-- We repeat the list explicitly below.

UPDATE `creature_loot_template`
SET `Item` = 40753
WHERE `entry` IN (
    29122,29123,29124,29125,29126,29127,29128,29129,29130,29131,29132,
    28860,27635,
    25038,25040,25041,25042
)
  AND `Item` IN (47241, 40752, 45624);

UPDATE `reference_loot_template` rl
JOIN `creature_loot_template` cl ON cl.`Reference` = rl.`Entry`
SET rl.`Item` = 40753
WHERE cl.`entry` IN (
    29122,29123,29124,29125,29126,29127,29128,29129,29130,29131,29132,
    28860,27635,
    25038,25040,25041,25042
)
  AND rl.`Item` IN (47241, 40752, 45624);

-- =====================================================
-- 3) ULDUAR BOSSES => CONQUEST (45624)
-- =====================================================
-- We detect Ulduar bosses by: spawn exists in map 603 AND creature_template.rank = 3.
UPDATE `creature_loot_template` cl
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET cl.`Item` = 45624
WHERE cl.`Item` IN (47241, 40752, 40753)
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
WHERE rl.`Item` IN (47241, 40752, 40753)
  AND ct.`rank` = 3
  AND EXISTS (
    SELECT 1
    FROM `creature` cr
    WHERE cr.`map` = 603
      AND cr.`id1` = cl.`entry`
  );
