-- Set RDF/LFG daily quest rewards for ICC + Dungeon Finder era (Bracket 80_4_1)
-- Desired behavior (blizzlike 3.3):
-- - 1st random heroic of the day: 2x Emblem of Frost (49426)
-- - Subsequent random heroics: 2x Emblem of Triumph (47241)
--
-- Quest IDs (AzerothCore WotLK):
-- 24788: Daily heroic random (1st)
-- 24789: Daily heroic random (Nth)

UPDATE `quest_template` SET `rewarditem1` = 49426, `RewardAmount1` = 2 WHERE `ID` = 24788; -- Daily 1st, Frost x2 (heroic)
UPDATE `quest_template` SET `rewarditem1` = 47241, `RewardAmount1` = 2 WHERE `ID` = 24789; -- Daily Nth, Triumph x2 (heroic)
