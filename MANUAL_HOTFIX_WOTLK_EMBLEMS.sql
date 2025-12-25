-- Manual hotfix: WotLK emblem distribution (AzerothCore world DB)
-- Run this manually against your `world` database.
--
-- Objetivo (blizzlike, según lo pedido):
--  - Heroicas 5-man (BOSSES): Emblema de Heroísmo (40752)
--  - Naxx/EoE/OS (BOSSES): Emblema de Valor (40753)
--  - Ulduar (BOSSES): Emblema de Conquista (45624)
--  - Recompensa RDF/LFG random heroic: Valor (quest 24788), siguientes: Heroísmo (quest 24789)
--
-- Emblems:
--  Heroism  40752
--  Valor    40753
--  Conquest 45624
--  Triumph  47241
--  Frost    49426

START TRANSACTION;

-- =====================================================
-- 0) RDF / LFG rewards (random heroic)
-- =====================================================
-- Dungeon Finder (RDF) reward table -> quest ids
UPDATE `lfg_dungeon_rewards`
SET `firstQuestId` = 24788, `otherQuestId` = 24789
WHERE `dungeonId` IN (261, 262)
  AND `maxLevel` = 80;

-- Ensure those quests reward the correct emblems
UPDATE `quest_template` SET `RewardItem1` = 40753, `RewardAmount1` = 1 WHERE `ID` = 24788;
UPDATE `quest_template` SET `RewardItem1` = 40752, `RewardAmount1` = 1 WHERE `ID` = 24789;

-- =====================================================
-- 1) HEROIC 5-MAN DUNGEON BOSSES => HEROISM (40752)
-- =====================================================
-- Scope: boss creatures (rank=3) that have spawns inside maps whose instance_template.maxPlayers=5.
-- This is intentionally scoped to avoid touching raid loot.

-- Direct emblem rows on boss loot
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

-- Emblems coming from reference loot templates
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
-- Boss IDs (from the module's enable script):
-- Naxx: 29122..29132
-- EoE: 28860 (Malygos), 27635 (Alexstrasza)
-- OS: 25038,25040,25041,25042

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
-- Detection: spawn exists in map 603 AND creature_template.rank=3.

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

COMMIT;

-- Optional quick checks (run manually if you want):
-- How many emblem entries remain on 5-man bosses?
-- SELECT cl.`Item`, COUNT(*)
-- FROM `creature_loot_template` cl
-- JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
-- WHERE ct.`rank`=3 AND cl.`Item` IN (40752,40753,45624,47241)
-- GROUP BY cl.`Item`;
