-- 65-69 level range - Sethekk Halls, Auchenai Crypts, The Escape from Durnholde
UPDATE `disables` SET `flags`=`flags`&~1 WHERE `sourceType` IN (2, 8) AND `entry` IN (556, 558, 560);
