-- Set RDF/LFG daily quest rewards for early WotLK era (Bracket 80_1_2)
-- Keeps Triumph out of early brackets.
UPDATE `quest_template` SET `rewarditem1` = 40752 WHERE `ID` = 24790; -- Daily Nth, Heroism (normal)
UPDATE `quest_template` SET `rewarditem1` = 40752 WHERE `ID` = 24789; -- Daily Nth, Heroism (heroic)
UPDATE `quest_template` SET `rewarditem1` = 40753, `RewardAmount1` = 1 WHERE `ID` = 24788; -- Daily 1st, Valor (heroic)
