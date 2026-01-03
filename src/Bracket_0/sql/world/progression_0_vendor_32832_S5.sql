/* ---------------------------------------------------------
   NPC 32832 - BORRAR TODO y CARGAR VENDOR (desde wotlkdb HTML)
   AzerothCore WotLK - MySQL 8.4

   ENFASIS:
   - Este script RESPALDA y BORRA TODO lo existente del vendor
     (npc_vendor y game_event_npc_vendor) para el NPC 32832,
     y luego INSERTA nuevamente TODO con precios correctos.

   - Usa itemextendedcost_dbc existente (NO inventa IDs)
--------------------------------------------------------- */

START TRANSACTION;

SET @npc := 32832;

-- =========================================================
-- A) BACKUP + BORRADO FUERTE en npc_vendor (por entry)
-- =========================================================

DROP TABLE IF EXISTS backupKambi_npc_vendor_32832_20260101;
CREATE TABLE backupKambi_npc_vendor_32832_20260101 LIKE npc_vendor;

INSERT INTO backupKambi_npc_vendor_32832_20260101
SELECT *
FROM npc_vendor
WHERE entry = @npc;

DELETE FROM npc_vendor
WHERE entry = @npc;

-- =========================================================
-- B) BACKUP + BORRADO FUERTE por EVENTO (game_event_npc_vendor)
-- =========================================================

DROP TABLE IF EXISTS backupKambi_game_event_npc_vendor_32832_20260101;
CREATE TABLE backupKambi_game_event_npc_vendor_32832_20260101 LIKE game_event_npc_vendor;

INSERT INTO backupKambi_game_event_npc_vendor_32832_20260101
SELECT gev.*
FROM game_event_npc_vendor gev
JOIN creature c ON c.guid = gev.guid
WHERE c.id1 = @npc;

DELETE gev
FROM game_event_npc_vendor gev
JOIN creature c ON c.guid = gev.guid
WHERE c.id1 = @npc;

-- =========================================================
-- C) CARGA: lista de items (ItemID, ArenaPoints, HonorPoints, Rating)
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS tmp_items_32832;
CREATE TEMPORARY TABLE tmp_items_32832 (
    rn INT PRIMARY KEY AUTO_INCREMENT,
    item INT NOT NULL,
    arena INT NOT NULL,
    honor INT NOT NULL,
    rating INT NOT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_items_32832 (item, arena, honor, rating) VALUES
    (40778,0,60000,0),
    (40779,0,60000,0),
    (40780,0,60000,0),
    (40797,0,50000,0),
    (40798,0,50000,0),
    (40799,0,50000,0),
    (40816,0,60000,0),
    (40817,0,60000,0),
    (40818,0,60000,0),
    (40836,0,60000,0),
    (40837,0,60000,0),
    (40838,0,60000,0),
    (40856,0,50000,0),
    (40857,0,50000,0),
    (40858,0,50000,0),
    (40898,0,60000,0),
    (40918,0,50000,0),
    (40930,0,60000,0),
    (40936,0,60000,0),
    (40960,0,50000,0),
    (40986,0,60000,0),
    (40987,0,60000,0),
    (40998,0,50000,0),
    (41004,0,50000,0),
    (41010,0,60000,0),
    (41016,0,60000,0),
    (41023,0,60000,0),
    (41024,0,50000,0),
    (41030,0,60000,0),
    (41041,0,50000,0),
    (41078,0,60000,0),
    (41084,0,60000,0),
    (41134,0,50000,0),
    (41140,0,50000,0),
    (41148,0,60000,0),
    (41154,0,60000,0),
    (41160,0,60000,0),
    (41202,0,60000,0),
    (41208,0,50000,0),
    (41214,0,50000,0),
    (41268,0,50000,0),
    (41269,0,60000,0),
    (41270,0,60000,0),
    (41271,0,50000,0),
    (41272,0,60000,0),
    (41278,0,50000,0),
    (41290,0,50000,0),
    (41301,0,60000,0),
    (41313,0,60000,0),
    (41324,0,60000,0),
    (41643,0,50000,0),
    (41644,0,60000,0),
    (41645,0,60000,0),
    (41646,0,50000,0),
    (41647,0,60000,0),
    (41658,0,60000,0),
    (41664,0,60000,0),
    (41675,0,60000,0),
    (41712,0,50000,0),
    (41770,0,50000,0),
    (41847,0,50000,0),
    (41848,0,60000,0),
    (41849,0,60000,0),
    (41850,0,50000,0),
    (41851,0,60000,0),
    (41912,0,60000,0),
    (41918,0,60000,0),
    (41924,0,60000,0),
    (41930,0,50000,0),
    (41937,0,50000,0),
    (41943,0,60000,0),
    (41949,0,60000,0),
    (41956,0,60000,0),
    (41962,0,50000,0),
    (41968,0,50000,0),
    (41990,0,60000,0),
    (41996,0,60000,0),
    (42002,0,60000,0),
    (42008,0,50000,0),
    (42014,0,50000,0);

SELECT COUNT(*) AS tmp_items_rows FROM tmp_items_32832;

-- =========================================================
-- D) RESOLVER ExtendedCost existente (deduplicado por costo)
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS tmp_cost_defs_32832;
CREATE TEMPORARY TABLE tmp_cost_defs_32832 (
    cost_rn INT PRIMARY KEY AUTO_INCREMENT,
    arena INT NOT NULL,
    honor INT NOT NULL,
    rating INT NOT NULL,
    extendedCostId INT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_cost_defs_32832 (arena, honor, rating)
SELECT DISTINCT arena, honor, rating
FROM tmp_items_32832
ORDER BY arena, honor, rating;

SELECT COUNT(*) AS distinct_cost_defs FROM tmp_cost_defs_32832;

UPDATE tmp_cost_defs_32832 d
SET d.extendedCostId = (
    SELECT iec.ID
    FROM itemextendedcost_dbc iec
    WHERE iec.HonorPoints = d.honor
      AND iec.ArenaPoints = d.arena
      AND iec.RequiredArenaRating = d.rating
      AND iec.ItemID_1 = 0 AND iec.ItemID_2 = 0 AND iec.ItemID_3 = 0 AND iec.ItemID_4 = 0 AND iec.ItemID_5 = 0
      AND iec.ItemCount_1 = 0 AND iec.ItemCount_2 = 0 AND iec.ItemCount_3 = 0 AND iec.ItemCount_4 = 0 AND iec.ItemCount_5 = 0
      AND iec.ItemPurchaseGroup = 0
    ORDER BY iec.ArenaBracket ASC, iec.ID ASC
    LIMIT 1
);

SET @missing_cost_defs := (
    SELECT COUNT(*)
    FROM tmp_cost_defs_32832
    WHERE extendedCostId IS NULL
);

SELECT @missing_cost_defs AS missing_cost_defs;
SELECT arena, honor, rating FROM tmp_cost_defs_32832 WHERE extendedCostId IS NULL ORDER BY arena, honor, rating;
SELECT IF(@missing_cost_defs = 0, 'OK - ExtendedCost resueltos', 1/0) AS extendedcost_status;

-- =========================================================
-- E) INSERT: vendor en npc_vendor (entry=32832)
-- =========================================================

INSERT INTO npc_vendor
(entry, slot, item, maxcount, incrtime, ExtendedCost, VerifiedBuild)
SELECT @npc AS entry,
       (i.rn - 1) AS slot,
       i.item,
       0 AS maxcount,
       0 AS incrtime,
       d.extendedCostId AS ExtendedCost,
       0 AS VerifiedBuild
FROM tmp_items_32832 i
JOIN tmp_cost_defs_32832 d
  ON d.arena = i.arena
 AND d.honor = i.honor
 AND d.rating = i.rating
ORDER BY i.rn;

COMMIT;

-- =========================================================
-- F) CHECKS
-- =========================================================

SELECT DATABASE() AS current_db;

SELECT COUNT(*) AS npc_vendor_items_32832
FROM npc_vendor
WHERE entry = @npc;

SELECT *
FROM npc_vendor
WHERE entry = @npc
ORDER BY slot, item;

SELECT gev.eventEntry, gev.guid, gev.item, gev.ExtendedCost
FROM game_event_npc_vendor gev
JOIN creature c ON c.guid = gev.guid
WHERE c.id1 = @npc
ORDER BY gev.eventEntry, gev.guid, gev.item;
