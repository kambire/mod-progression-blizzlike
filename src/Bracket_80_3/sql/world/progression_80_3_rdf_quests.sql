-- Set RDF/LFG daily quest rewards for ToC era (Bracket 80_3)
-- Blizzlike 3.2 note:
-- - The (daily / 1st) heroic reward is 2x Emblem of Triumph.
UPDATE `quest_template` SET `rewarditem1` = 47241, `RewardAmount1` = 1 WHERE `ID` = 24789; -- Daily Nth, Triumph (heroic)
UPDATE `quest_template` SET `rewarditem1` = 47241, `RewardAmount1` = 2 WHERE `ID` = 24788; -- Daily 1st, Triumph x2 (heroic)
