/* ---------------------------------------------------------
   NPC 32381 - BORRAR TODO y CARGAR VENDOR (desde wotlkdb HTML)
   AzerothCore WotLK - MySQL 8.4

   ENFASIS:
   - Este script RESPALDA y BORRA TODO lo existente del vendor
     (npc_vendor y game_event_npc_vendor) para el NPC 32381,
     y luego INSERTA nuevamente TODO con precios correctos.

   - Usa itemextendedcost_dbc existente (NO inventa IDs)
--------------------------------------------------------- */

START TRANSACTION;

SET @npc := 32381;

-- =========================================================
-- A) BACKUP + BORRADO FUERTE en npc_vendor (por entry)
-- =========================================================

DROP TABLE IF EXISTS backupKambi_npc_vendor_32381_20260101;
CREATE TABLE backupKambi_npc_vendor_32381_20260101 LIKE npc_vendor;

INSERT INTO backupKambi_npc_vendor_32381_20260101
SELECT *
FROM npc_vendor
WHERE entry = @npc;

DELETE FROM npc_vendor
WHERE entry = @npc;

-- =========================================================
-- B) BACKUP + BORRADO FUERTE por EVENTO (game_event_npc_vendor)
-- =========================================================

DROP TABLE IF EXISTS backupKambi_game_event_npc_vendor_32381_20260101;
CREATE TABLE backupKambi_game_event_npc_vendor_32381_20260101 LIKE game_event_npc_vendor;

INSERT INTO backupKambi_game_event_npc_vendor_32381_20260101
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

DROP TEMPORARY TABLE IF EXISTS tmp_items_32381;
CREATE TEMPORARY TABLE tmp_items_32381 (
    rn INT PRIMARY KEY AUTO_INCREMENT,
    item INT NOT NULL,
    arena INT NOT NULL,
    honor INT NOT NULL,
    rating INT NOT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_items_32381 (item, arena, honor, rating) VALUES
    (40877,0,49600,0),
    (40878,0,49600,0),
    (40887,0,31600,0),
    (40966,0,49600,0),
    (40972,0,31600,0),
    (40973,0,49600,0),
    (41047,0,31600,0),
    (41049,0,49600,0),
    (41050,0,49600,0),
    (41063,0,31600,0),
    (41068,0,49600,0),
    (41073,0,49600,0),
    (41223,0,31600,0),
    (41228,0,49600,0),
    (41233,0,49600,0),
    (41330,0,49600,0),
    (41331,0,49600,0),
    (41332,0,31600,0),
    (41628,0,49600,0),
    (41633,0,49600,0),
    (41638,0,31600,0),
    (41827,0,49600,0),
    (41828,0,49600,0),
    (41830,0,31600,0),
    (41877,0,49600,0),
    (41878,0,31600,0),
    (41879,0,49600,0),
    (41896,0,49600,0),
    (41901,0,49600,0),
    (41907,0,31600,0),
    (42020,0,38000,0),
    (42021,0,38000,0),
    (42022,0,38000,0),
    (42023,0,38000,0),
    (42024,0,38000,0),
    (42025,0,38000,0),
    (42026,0,38000,0),
    (42055,0,38000,0),
    (42056,0,38000,0),
    (42057,0,38000,0),
    (42058,0,38000,0),
    (42059,0,38000,0),
    (42060,0,38000,0),
    (42061,0,38000,0),
    (42110,0,38000,0),
    (42112,0,38000,0),
    (42123,0,49600,0)
;

SELECT COUNT(*) AS tmp_items_rows FROM tmp_items_32381;

-- =========================================================
-- D) RESOLVER ExtendedCost existente (deduplicado por costo)
-- =========================================================

DROP TEMPORARY TABLE IF EXISTS tmp_cost_defs_32381;
CREATE TEMPORARY TABLE tmp_cost_defs_32381 (
    cost_rn INT PRIMARY KEY AUTO_INCREMENT,
    arena INT NOT NULL,
    honor INT NOT NULL,
    rating INT NOT NULL,
    extendedCostId INT NULL
) ENGINE = MEMORY;

INSERT INTO tmp_cost_defs_32381 (arena, honor, rating)
SELECT DISTINCT arena, honor, rating
FROM tmp_items_32381
ORDER BY arena, honor, rating;

SELECT COUNT(*) AS distinct_cost_defs FROM tmp_cost_defs_32381;

UPDATE tmp_cost_defs_32381 d
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
    FROM tmp_cost_defs_32381
    WHERE extendedCostId IS NULL
);

SELECT @missing_cost_defs AS missing_cost_defs;
SELECT arena, honor, rating FROM tmp_cost_defs_32381 WHERE extendedCostId IS NULL ORDER BY arena, honor, rating;
SELECT IF(@missing_cost_defs = 0, 'OK - ExtendedCost resueltos', 1/0) AS extendedcost_status;

-- =========================================================
-- E) INSERT: vendor en npc_vendor (entry=32381)
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
FROM tmp_items_32381 i
JOIN tmp_cost_defs_32381 d
  ON d.arena = i.arena
 AND d.honor = i.honor
 AND d.rating = i.rating
ORDER BY i.rn;

COMMIT;

-- =========================================================
-- F) CHECKS
-- =========================================================

SELECT DATABASE() AS current_db;

SELECT COUNT(*) AS npc_vendor_items_32381
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


