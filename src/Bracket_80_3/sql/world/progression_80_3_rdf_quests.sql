-- Set RDF/LFG daily quest rewards for ToC era (Bracket 80_3)
-- Triumph should start here.
UPDATE `quest_template` SET `rewarditem1` = 47241 WHERE `ID` = 24789; -- Daily Nth, Triumph (heroic)
UPDATE `quest_template` SET `rewarditem1` = 47241, `RewardAmount1` = 1 WHERE `ID` = 24788; -- Daily 1st, Triumph (heroic)
