# 🚀 COMPLETAR E IMPLEMENTAR SQL SCRIPTS

**Estatus**: Scripts templates listos, necesitan ser completados con IDs reales

---

## 📍 Ubicación de Scripts

Todos los scripts templates están en sus carpetas correctas:

```
src/Bracket_70_2_1/sql/world/vendors_cleanup_s1.sql
src/Bracket_70_2_2/sql/world/vendors_cleanup_s2.sql
src/Bracket_70_5/sql/world/vendors_cleanup_s3.sql
src/Bracket_70_6_2/sql/world/vendors_cleanup_s4.sql
src/Bracket_80_1_2/sql/world/vendors_cleanup_s5.sql
src/Bracket_80_1_2/sql/world/vendors_transition_tbc_to_wotlk.sql
src/Bracket_80_2/sql/world/vendors_cleanup_s6.sql
src/Bracket_80_3/sql/world/vendors_cleanup_s7.sql
src/Bracket_80_4_1/sql/world/vendors_cleanup_s8.sql
```

---

## 🔍 PASO 1: Encontrar IDs en tu Base de Datos

Ejecuta estas queries en MySQL para obtener los IDs necesarios:

### Query 1: Vendor ID en Gadgetzan
```sql
SELECT entry, name FROM creature WHERE map=1 AND name LIKE '%vendor%' LIMIT 5;
-- Copia el ENTRY de Gadgetzan
```

### Query 2: Vendor ID en Area 52
```sql
SELECT entry, name FROM creature WHERE map=530 AND name LIKE '%vendor%' LIMIT 5;
-- Copia el ENTRY de Area 52
```

### Query 3: Vendor ID en Dalaran
```sql
SELECT entry, name FROM creature WHERE map=571 AND name LIKE '%vendor%' LIMIT 5;
-- Copia el ENTRY de Dalaran
```

### Query 4: Items por Season

```sql
-- Season 1-2 (Gladiator)
SELECT entry, name FROM item_template WHERE name LIKE '%Gladiator%' AND name NOT LIKE '%Hateful%' AND name NOT LIKE '%Brutal%' ORDER BY entry;

-- Season 3 (Hateful)
SELECT entry, name FROM item_template WHERE name LIKE '%Hateful%' ORDER BY entry;

-- Season 4 (Brutal)
SELECT entry, name FROM item_template WHERE name LIKE '%Brutal%' ORDER BY entry;

-- Season 5-6 (Wrathful)
SELECT entry, name FROM item_template WHERE name LIKE '%Wrathful%' AND name NOT LIKE '%Vindictive%' AND name NOT LIKE '%Relentless%' ORDER BY entry;

-- Season 7 (Vindictive)
SELECT entry, name FROM item_template WHERE name LIKE '%Vindictive%' ORDER BY entry;

-- Season 8 (Relentless)
SELECT entry, name FROM item_template WHERE name LIKE '%Relentless%' ORDER BY entry;
```

---

## ✏️ PASO 2: Completar los Templates

### Formato del Script Completado

```sql
-- Ejemplo: vendors_cleanup_s1.sql

DELETE FROM npc_vendor 
WHERE entry = 18945  -- REEMPLAZAR CON ID REAL
  AND item_template NOT IN (
    23001,23002,23003,23004,23005,23006,23007,23008,23009,23010,  -- 10
    23011,23012,23013,23014,23015,23016,23017,23018,23019,23020,  -- 20
    23021,23022,23023,23024,23025,23026,23027,23028,23029,23030,  -- 30
    23031,23032,23033,23034,23035,23036,23037,23038,23039,23040,  -- 40
    23041,23042,23043,23044,23045,23046,23047,23048,23049,23050,  -- 50
    23051,23052,23053,23054,23055,23056,23057,23058,23059,23060   -- 60
  );

INSERT INTO npc_vendor (entry, item_template, maxcount, incrtime, slot, price_1)
VALUES
  (18945, 23001, 0, 0, 0, 150000),
  (18945, 23002, 0, 0, 0, 150000),
  (18945, 23003, 0, 0, 0, 150000),
  -- ... 60 items total ...
  (18945, 23060, 0, 0, 0, 150000)
;
```

---

## 📋 Checklist de Reemplazos

### Para TBC (Gadgetzan)

- [ ] **Reemplazar `[GADGETZAN_VENDOR_ID]`**
  - En: vendors_cleanup_s1.sql, s2.sql, s3.sql, s4.sql
  - Con: ID encontrado en Query 1
  - Ejemplo: 18945

- [ ] **Reemplazar `[S1_ITEM_IDS]`**
  - En: vendors_cleanup_s1.sql, s2.sql, s3.sql, s4.sql
  - Con: IDs de Gladiator items (Season 1-2)
  - Cantidad: ~60 items

- [ ] **Reemplazar `[S2_ITEM_IDS]`**
  - En: vendors_cleanup_s2.sql, s3.sql, s4.sql
  - Con: IDs de Gladiator items (Season 2)
  - Cantidad: ~60 items

- [ ] **Reemplazar `[S3_ITEM_IDS]`**
  - En: vendors_cleanup_s3.sql, s4.sql
  - Con: IDs de Hateful items
  - Cantidad: ~60 items

- [ ] **Reemplazar `[S4_ITEM_IDS]`**
  - En: vendors_cleanup_s4.sql
  - Con: IDs de Brutal items
  - Cantidad: ~60 items

### Para WotLK (Dalaran)

- [ ] **Reemplazar `[DALARAN_VENDOR_ID]`**
  - En: vendors_transition_tbc_to_wotlk.sql, s5.sql, s6.sql, s7.sql, s8.sql
  - Con: ID encontrado en Query 3
  - Ejemplo: 31234

- [ ] **Reemplazar `[S5_ITEM_IDS]`**
  - En: vendors_cleanup_s5.sql, s6.sql, s7.sql, s8.sql
  - Con: IDs de Wrathful items (Season 5)
  - Cantidad: ~60 items

- [ ] **Reemplazar `[S6_ITEM_IDS]`**
  - En: vendors_cleanup_s6.sql, s7.sql, s8.sql
  - Con: IDs de Wrathful items (Season 6)
  - Cantidad: ~60 items

- [ ] **Reemplazar `[S7_ITEM_IDS]`**
  - En: vendors_cleanup_s7.sql, s8.sql
  - Con: IDs de Vindictive items
  - Cantidad: ~60 items

- [ ] **Reemplazar `[S8_ITEM_IDS]`**
  - En: vendors_cleanup_s8.sql
  - Con: IDs de Relentless items
  - Cantidad: ~60 items

---

## 🔗 Para Otros Vendors (Si aplica)

- [ ] **Reemplazar `[AREA52_VENDOR_ID]`**
  - En: vendors_transition_tbc_to_wotlk.sql
  - Con: ID encontrado en Query 2

---

## ⚡ PASO 3: Ejecutar en Servidor

### Opción 1: Copiar a servidor (automático)
```bash
# Los scripts se cargarán automáticamente si están en las carpetas correctas
# Al reiniciar el servidor o ejecutar update
```

### Opción 2: Ejecutar manualmente
```sql
-- Conectarse a MySQL y ejecutar:
mysql world < src/Bracket_70_2_1/sql/world/vendors_cleanup_s1.sql
mysql world < src/Bracket_70_2_2/sql/world/vendors_cleanup_s2.sql
-- ... etc ...
```

### Opción 3: Copiar scripts a updates
```bash
cp src/Bracket_*/sql/world/vendors_*.sql ~/path/to/updates/
# El updater de AzerothCore los ejecutará automáticamente
```

---

## ✅ PASO 4: Validar en Juego

```
[ ] Entra a Bracket_70_2_1 y verifica:
    - Vendor visible en Gadgetzan
    - Solo items de S1 (Gladiator S1)
    - Precio 150,000 gold

[ ] Entra a Bracket_70_2_2 y verifica:
    - Vendor visible en Gadgetzan
    - Items de S1 (100k) y S2 (200k)
    - Total ~120 items

[ ] Entra a Bracket_80_1_2 y verifica:
    - Gadgetzan vendor desaparecido
    - Nuevo vendor en Dalaran
    - Solo items S5

[ ] Entra a Bracket_80_4_1 y verifica:
    - Todos los items disponibles
    - Precios correctos
```

---

## 📝 Resumen Rápido

| Paso | Acción | Tiempo |
|------|--------|--------|
| 1 | Ejecutar 6 queries en BD | 5 min |
| 2 | Completar 9 templates SQL | 30 min |
| 3 | Copiar scripts al servidor | 5 min |
| 4 | Reiniciar servidor | 2 min |
| 5 | Validar en juego | 15 min |
| **Total** | | **57 minutos** |

---

## 🎯 Archivos Importantes

- **README.md** - Documentación completa
- **PARAMETROS_TECNICOS_DESARROLLO.md** - Configuración técnica
- **BRACKET_DESCRIPTIONS_COMPLETE.md** - Descripción de brackets
- **ARENA_SEASONS_VALIDATION.md** - Mapeo de seasons

---

**¿Necesitas ayuda?** Consulta README.md sección "FASE 0 - Control Total de Vendors"
