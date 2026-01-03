/* ---------------------------------------------------------
   NPC 33939 - BORRAR TODO y CARGAR VENDOR (lista Arena/Honor/Rating)
   AzerothCore WotLK - MySQL 8.4
   - Compatible con el esquema real de itemextendedcost_dbc:
     (ID, HonorPoints, ArenaPoints, ArenaBracket, ItemID_1..5, ItemCount_1..5,
      RequiredArenaRating, ItemPurchaseGroup)
   - Limpia npc_vendor + game_event_npc_vendor (si aplica)
   - Crea ExtendedCost nuevos SOLO para combinaciones distintas de costo
--------------------------------------------------------- */

START TRANSACTION;

SET @npc := 33939;

-- =========================================================
-- A) BACKUP + LIMPIEZA en npc_vendor (por entry)
-- =========================================================

DROP TABLE IF EXISTS `backupKambi_npc_vendor_33939_20260101`;
CREATE TABLE `backupKambi_npc_vendor_33939_20260101` LIKE `npc_vendor`;

INSERT INTO `backupKambi_npc_vendor_33939_20260101`
SELECT *
FROM `npc_vendor`
WHERE `entry` = @npc;

DELETE FROM `npc_vendor`
WHERE `entry` = @npc;

-- =========================================================
-- B) LIMPIEZA por EVENTO (si el vendor está por game_event_npc_vendor)
-- =========================================================

DROP TABLE IF EXISTS `backupKambi_game_event_npc_vendor_33939_20260101`;
CREATE TABLE `backupKambi_game_event_npc_vendor_33939_20260101` LIKE `game_event_npc_vendor`;

INSERT INTO `backupKambi_game_event_npc_vendor_33939_20260101`
SELECT gev.*
FROM `game_event_npc_vendor` gev
JOIN `creature` c ON c.`guid` = gev.`guid`
WHERE c.`id1` = @npc;

DELETE gev
FROM `game_event_npc_vendor` gev
JOIN `creature` c ON c.`guid` = gev.`guid`
WHERE c.`id1` = @npc;

-- =========================================================
-- C) CARGA: lista de items (ItemID, Arena, Honor, Rating)
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS tmp_items_33939;
CREATE TEMPORARY TABLE tmp_items_33939 (
    rn INT PRIMARY KEY AUTO_INCREMENT,
    item INT NOT NULL,
    arena INT NOT NULL,
    honor INT NOT NULL,
    rating INT NOT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_items_33939 (item, arena, honor, rating) VALUES
    (51396,350,0,1800),
    (51407,350,0,1800),
    (51408,350,0,1800),
    (51409,350,0,1800),
    (51413,2370,0,1600),
    (51414,1430,0,1400),
    (51415,2370,0,1950),
    (51416,2370,0,1500),
    (51417,1260,0,1700),
    (51418,1930,0,2000),
    (51419,2370,0,1600),
    (51420,1430,0,1400),
    (51421,2370,0,1950),
    (51422,2370,0,1500),
    (51423,1260,0,1700),
    (51424,1930,0,2000),
    (51425,2370,0,1600),
    (51426,1430,0,1400),
    (51427,2370,0,1950),
    (51428,2370,0,1500),
    (51429,1260,0,1700),
    (51430,1930,0,2000),
    (51433,2370,0,1600),
    (51434,1430,0,1400),
    (51435,2370,0,1950),
    (51436,2370,0,1500),
    (51437,1260,0,1700),
    (51438,1930,0,2000),
    (51452,350,0,1800),
    (51455,350,0,1800),
    (51458,2370,0,1600),
    (51459,1430,0,1400),
    (51460,2370,0,1950),
    (51461,2370,0,1500),
    (51462,1930,0,2000),
    (51463,2370,0,1600),
    (51464,1430,0,1400),
    (51465,2370,0,1950),
    (51466,2370,0,1500),
    (51467,1930,0,2000),
    (51468,2370,0,1600),
    (51469,1430,0,1400),
    (51470,2370,0,1950),
    (51471,2370,0,1500),
    (51472,1260,0,1700),
    (51473,1930,0,2000),
    (51474,2370,0,1600),
    (51475,1430,0,1400),
    (51476,2370,0,1950),
    (51477,2370,0,1500),
    (51478,1260,0,1700),
    (51479,1930,0,2000),
    (51482,2370,0,1600),
    (51483,1430,0,1400),
    (51484,2370,0,1950),
    (51485,2370,0,1500),
    (51486,1930,0,2000),
    (51487,2370,0,1600),
    (51488,1430,0,1400),
    (51489,2370,0,1950),
    (51490,2370,0,1500),
    (51491,1930,0,2000),
    (51492,2370,0,1600),
    (51493,1430,0,1400),
    (51494,2370,0,1950),
    (51495,2370,0,1500),
    (51496,1930,0,2000),
    (51497,2370,0,1600),
    (51498,1430,0,1400),
    (51499,2370,0,1950),
    (51500,2370,0,1500),
    (51501,1260,0,1700),
    (51502,1930,0,2000),
    (51503,2370,0,1600),
    (51504,1430,0,1400),
    (51505,2370,0,1950),
    (51506,2370,0,1500),
    (51507,1260,0,1700),
    (51508,1930,0,2000),
    (51509,2370,0,1600),
    (51510,1430,0,1400),
    (51511,2370,0,1950),
    (51512,2370,0,1500),
    (51513,1260,0,1700),
    (51514,1930,0,2000),
    (51533,350,0,1800),
    (51536,2370,0,1600),
    (51537,1430,0,1400),
    (51538,2370,0,1950),
    (51539,2370,0,1500),
    (51540,1930,0,2000),
    (51541,2370,0,1600),
    (51542,1430,0,1400),
    (51543,2370,0,1950),
    (51544,2370,0,1500),
    (51545,1930,0,2000),
    (51388,1540,55000,1800),
    (51390,1540,55000,1800),
    (51392,1540,55000,1800),
    (51394,1540,55000,1800),
    (51397,1300,38500,1800),
    (51400,1540,55000,1800),
    (51402,1540,55000,1800),
    (51404,1540,55000,1800),
    (51406,1300,38500,1800),
    (51410,1260,0,1700),
    (51411,1540,55000,1800),
    (51431,1540,55000,1800),
    (51439,450,16500,1800),
    (51441,450,16500,1800),
    (51443,450,16500,1800),
    (51445,450,16500,1800),
    (51447,450,16500,1800),
    (51449,1540,55000,1800),
    (51451,1260,0,1700),
    (51453,1300,38500,1800),
    (51456,1540,55000,1800),
    (51480,1540,55000,1800),
    (51515,1090,38500,1800),
    (51517,1090,38500,1800),
    (51519,1090,38500,1800),
    (51521,1090,38500,1800),
    (51523,1090,38500,1800),
    (51525,450,16500,1800),
    (51527,450,16500,1800),
    (51530,450,16500,1800),
    (51531,1260,0,1700),
    (51532,1260,0,1700),
    (51535,1260,0,1700);

-- Sanity checks: si esto da 0, el insert de la lista no corrió
SELECT COUNT(*) AS tmp_items_rows FROM tmp_items_33939;

-- =========================================================
-- D) RESOLVER ExtendedCost existente (deduplicado por costo)
--    IMPORTANTE: el core valida ExtendedCost contra el DBC (ItemExtendedCost.dbc).
--    Si usas IDs inventados (ej. 9000xx) el servidor los ignora y NO muestra los items.
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS tmp_cost_defs_33939;
CREATE TEMPORARY TABLE tmp_cost_defs_33939 (
    cost_rn INT PRIMARY KEY AUTO_INCREMENT,
    arena INT NOT NULL,
    honor INT NOT NULL,
    rating INT NOT NULL,
    extendedCostId INT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_cost_defs_33939 (arena, honor, rating)
SELECT DISTINCT arena, honor, rating
FROM tmp_items_33939
ORDER BY arena, honor, rating;

SELECT COUNT(*) AS distinct_cost_defs FROM tmp_cost_defs_33939;

UPDATE tmp_cost_defs_33939 d
SET d.extendedCostId = (
        SELECT iec.`ID`
        FROM `itemextendedcost_dbc` iec
        WHERE iec.`HonorPoints` = d.honor
            AND iec.`ArenaPoints` = d.arena
            AND iec.`RequiredArenaRating` = d.rating
            AND iec.`ItemID_1` = 0 AND iec.`ItemID_2` = 0 AND iec.`ItemID_3` = 0 AND iec.`ItemID_4` = 0 AND iec.`ItemID_5` = 0
            AND iec.`ItemCount_1` = 0 AND iec.`ItemCount_2` = 0 AND iec.`ItemCount_3` = 0 AND iec.`ItemCount_4` = 0 AND iec.`ItemCount_5` = 0
            AND iec.`ItemPurchaseGroup` = 0
        ORDER BY iec.`ArenaBracket` ASC, iec.`ID` ASC
        LIMIT 1
);

SET @missing_cost_defs := (
    SELECT COUNT(*)
    FROM tmp_cost_defs_33939
    WHERE extendedCostId IS NULL
);

SELECT @missing_cost_defs AS missing_cost_defs;

SELECT arena, honor, rating
FROM tmp_cost_defs_33939
WHERE extendedCostId IS NULL
ORDER BY arena, honor, rating;

-- Si falta algún ExtendedCost, forzamos error y se aborta el script.
-- IF() en MySQL evalúa solo la rama elegida; 1/0 dispara error solo cuando faltan.
SELECT IF(@missing_cost_defs = 0, 'OK - ExtendedCost resueltos', 1/0) AS extendedcost_status;

-- =========================================================
-- E) INSERT: vendor en npc_vendor (entry=33939)
-- =========================================================

INSERT INTO `npc_vendor`
(`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`)
SELECT @npc AS entry,
       (i.rn - 1) AS slot,
       i.item,
       0 AS maxcount,
       0 AS incrtime,
    d.extendedCostId AS ExtendedCost,
    0 AS VerifiedBuild
FROM tmp_items_33939 i
JOIN tmp_cost_defs_33939 d
  ON d.arena = i.arena
 AND d.honor = i.honor
 AND d.rating = i.rating
ORDER BY i.rn;

COMMIT;

-- =========================================================
-- F) CHECKS
-- =========================================================

SELECT DATABASE() AS current_db;

SELECT COUNT(*) AS npc_vendor_items_33939
FROM `npc_vendor`
WHERE `entry` = @npc;

SELECT *
FROM `npc_vendor`
WHERE `entry` = @npc
ORDER BY `slot`, `item`;

-- Si esto devuelve filas, el NPC sigue teniendo vendor por EVENTO (por GUID)
SELECT gev.eventEntry, gev.guid, gev.item, gev.ExtendedCost
FROM `game_event_npc_vendor` gev
JOIN `creature` c ON c.`guid` = gev.`guid`
WHERE c.`id1` = @npc
ORDER BY gev.eventEntry, gev.guid, gev.item;
