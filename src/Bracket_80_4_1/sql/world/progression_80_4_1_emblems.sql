-- WotLK emblem distribution fix (Bracket 80_4_1 / ICC + Dungeon Finder era)
-- Desired behavior (blizzlike 3.3):
-- - Heroic 5-man dungeon BOSSES: Emblem of Triumph (47241)
--
-- Emblem item IDs (WotLK):
-- Heroism 40752
-- Valor   40753
-- Conquest 45624
-- Triumph 47241
-- Frost   49426

-- =====================================================
-- 1) HEROIC 5-MAN DUNGEON BOSSES => TRIUMPH (47241)
-- =====================================================
UPDATE `creature_loot_template` cl
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET cl.`Item` = 47241
WHERE cl.`Item` IN (40752, 40753, 45624)
  AND ct.`rank` = 3
  AND EXISTS (
    SELECT 1
    FROM `creature` cr
    WHERE cr.`map` IN (574,575,576,578,595,599,600,601,602,604,608,619,632,658,668)
      AND cr.`id1` = cl.`entry`
  );

UPDATE `reference_loot_template` rl
JOIN `creature_loot_template` cl ON cl.`Reference` = rl.`Entry`
JOIN `creature_template` ct ON ct.`entry` = cl.`entry`
SET rl.`Item` = 47241
WHERE rl.`Item` IN (40752, 40753, 45624)
  AND ct.`rank` = 3
  AND EXISTS (
    SELECT 1
    FROM `creature` cr
    WHERE cr.`map` IN (574,575,576,578,595,599,600,601,602,604,608,619,632,658,668)
      AND cr.`id1` = cl.`entry`
  );
