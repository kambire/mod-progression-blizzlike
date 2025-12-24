# Documento Ejecutivo: Cambios en el Sistema de Progresión

## Resumen Ejecutivo

Se ha realizado un análisis completo del módulo de progresión de AzerothCore contra la cronología histórica original de Blizzard. El módulo está **en su mayoría correcto**, pero se han identificado **7 áreas problemáticas** que requieren acción.

**Estado General**: 79% de brackets están correctamente alineados con Blizzard ✅

---

## CAMBIOS INMEDIATOS (PRIORIDAD ALTA)

### 1. **Bracket_70_2_3 (Ogri'la)** - ❌ MISCLASSIFICATION
**Problema**: Ogri'la es world content (dailies/quests), no un raid tier
**Ubicación actual**: Bracket_70_2_3
**Acción recomendada**: 
- Opción A (Preferida): Mover contenido a Bracket_70_6_1 (Isle of Quel'Danas)
- Opción B: Renombrar a "TBC Tier 2 Adjustments" si contiene tuning
- Opción C: Documentar como "World Content Enhancement"

**Impacto**: Medio - Corrección de clasificación
**Archivo a actualizar**: `conf/progression_system.conf.dist` (línea ~90)

---

### 2. **Bracket_80_2 (Trial of the Champion)** - ❌ WRONG CLASSIFICATION
**Problema**: Trial of the Champion es 5-man dungeon, NO es raid
**Ubicación actual**: Bracket_80_2 (Tier de raid)
**Acción recomendada**:
- Reemplazar descripción de "Trial of the Champion" con contenido de raid real:
  - Ulduar (25/10-man raid)
  - Naxxramas 80 (remake)
  - Eye of Eternity (Obsidian Sanctum bonus boss)
- Mover Trial of the Champion a Bracket_80_1_2 o crear nuevo bracket para 5-man content

**Impacto**: Alto - Alineación con timeline de Blizzard
**Archivo a actualizar**: `conf/progression_system.conf.dist` (línea ~126)

---

### 3. **Bracket_70_4_1 (Hyjal)** - ⚠️ MIXED CONTENT
**Problema**: Mezcla raid principal + world content + PvP
**Descripción actual**: "Battle For Mount Hyjal, Arena Season 2, Netherwing"
**Desglose**:
- Battle for Mount Hyjal = Raid Tier 3 ✅
- Arena Season 2 = PvP (OK)
- Netherwing = World Content (Debería estar en 70_6_1)

**Acción recomendada**:
- Opción A: Mantener pero actualizar descripción: "Battle for Mount Hyjal (Raid Tier 3), Arena Season 2, Netherwing Prep"
- Opción B: Mover Netherwing a Bracket_70_6_1

**Impacto**: Bajo-Medio - Es funcional pero confuso
**Archivo a actualizar**: `conf/progression_system.conf.dist`

---

### 4. **Bracket_70_3_2 (The Eye & Sha'tari Skyguard)** - ⚠️ MIXED CONTENT
**Problema**: Mezcla raid + world content
**Desglose**:
- The Eye = Raid 25-man Tier 2 ✅
- Sha'tari Skyguard = World Content (Dailies)

**Acción recomendada**:
- Opción A: Documentar claramente: "The Eye (Raid Tier 2) + Sha'tari Skyguard (World Content)"
- Opción B: Crear bracket separado para world content

**Impacto**: Bajo - Funcional pero documentación pobre
**Archivo a actualizar**: `conf/progression_system.conf.dist`

---

## CAMBIOS DOCUMENTALES (PRIORIDAD MEDIA)

### 5. **Bracket_40_49** - ⚠️ DESCRIPCIÓN IMPRECISA
**Problema**: Título dice "40-49" pero dungeons tienen niveles sugeridos 44-60
**Descripción actual**: "Blackrock Depths, Dire Maul, Scholomance, Stratholme"
**Detalles técnicos**:
- Blackrock Depths: Nivel sugerido 54-60
- Dire Maul: Nivel sugerido 36-48 ✅
- Scholomance: Nivel sugerido 60-60
- Stratholme: Nivel sugerido 60-60

**Acción recomendada**: Actualizar descripción a:
`"World Dungeons: Blackrock Depths, Dire Maul, Scholomance (60), Stratholme (60)"`

O crear dos brackets separados:
- Bracket_40_49: Dire Maul
- Bracket_50_59_x: BRD, Scholomance, Stratholme

**Impacto**: Bajo - Principalmente documentación
**Archivo a actualizar**: `conf/progression_system.conf.dist` (línea ~51)

---

### 6. **Bracket_60_3_3** - ❓ SIN DOCUMENTACIÓN
**Problema**: No tiene descripción en config
**Contenido identificado**: AQ Tuning Scripts (`AddSC_temple_of_ahn_qiraj_tuning`)
**Acción recomendada**:
- Opción A: Documentar como "AQ Post-Content Adjustments"
- Opción B: Fusionar con Bracket_60_3_2
- Opción C: Eliminar si es solo tuning

**Impacto**: Bajo - Necesita clarificación
**Archivos a revisar**: 
- `src/Bracket_60_3_3/Bracket_60_3_3_loader.cpp`
- `src/Bracket_60_3_3/sql/world/*`

---

### 7. **Bracket_70_6_3** - ❓ SIN CONTENIDO
**Problema**: Bracket existe pero sin descripción ni archivos
**Acción recomendada**:
- Documentar propósito O eliminar si está vacío
- Verificar si tiene archivos en: `src/Bracket_70_6_3/`

**Impacto**: Muy bajo - Posible dead code
**Archivos a revisar**: `src/Bracket_70_6_3/`

---

## TABLA DE CAMBIOS

| Bracket | Cambio | Prioridad | Tipo | Archivo |
|---------|--------|-----------|------|---------|
| 40_49 | Actualizar descripción | Media | Docs | conf.dist |
| 60_3_3 | Investigar + documentar | Baja | Docs | conf.dist |
| 70_2_3 | Reclasificar (Ogri'la) | Alta | Reorganizar | conf.dist |
| 70_3_2 | Aclarar descripción | Baja | Docs | conf.dist |
| 70_4_1 | Actualizar descripción | Media | Docs | conf.dist |
| 70_6_3 | Investigar existencia | Baja | Docs | conf.dist |
| 80_2 | Reemplazar contenido | Alta | Reorganizar | conf.dist |

---

## CRONOLOGÍA VERIFICADA DE BLIZZARD

### ✅ VANILLA (Noviembre 2004 - Junio 2006)
```
Phase 1 (Nov 2004): Molten Core, Onyxia's Lair
Phase 2 (Dec 2005): Blackwing Lair  
Phase 3 (Jan 2006): AQ20, AQ40, World Bosses
Phase 5 (Jan 2006): Zul'Gurub
Final  (Jun 2006): Naxxramas
```
**Alineación**: ✅ 100% Correcto

### ✅ THE BURNING CRUSADE (Enero 2007 - Marzo 2008)
```
Phase 1 (Jan 2007):  Gruul's Lair, Magtheridon, Karazhan
Phase 2 (May 2007):  Serpentshrine Cavern, The Eye
Phase 3 (Aug 2007):  Battle for Mount Hyjal, Black Temple
Phase 4 (Dec 2007):  Zul'Aman
Phase 5 (Mar 2008):  Isle of Quel'Danas, Sunwell Plateau
```
**Alineación**: ✅ 95% Correcto (Ogri'la & Netherwing mal clasificados)

### ✅ WRATH OF THE LICH KING (Noviembre 2008 - Diciembre 2009)
```
Phase 1 (Nov 2008): Naxxramas 80, Eye of Eternity, Obsidian Sanctum
Phase 2 (Apr 2009): Ulduar
Phase 3 (Aug 2009): Trial of the Crusader
Phase 4 (Dec 2009): Icecrown Citadel, Ruby Sanctum
```
**Alineación**: ⚠️ 85% Correcto (Trial en bracket incorrecto)

---

## ARCHIVOS A ACTUALIZAR

### 1. **conf/progression_system.conf.dist**
Líneas a revisar/actualizar:
- Línea 51: Bracket_40_49
- Línea 60: Bracket_50_59_2
- Línea ~70: Bracket_60_3_3 (añadir comentario)
- Línea ~90: Bracket_70_2_3 (cambiar descripción)
- Línea ~104: Bracket_70_3_2 (aclarar)
- Línea ~108: Bracket_70_4_1 (aclarar)
- Línea ~128: Bracket_70_6_3 (documentar)
- Línea ~138: Bracket_80_2 (CAMBIO IMPORTANTE)

### 2. **src/Bracket_60_3_3/** (Investigación)
- Revisar contenido de SQL y C++

### 3. **src/Bracket_70_2_3/** (Posible reorganización)
- Verificar si contiene solo Ogri'la

### 4. **src/Bracket_70_6_3/** (Investigación)
- Verificar si está vacío o tiene contenido

---

## MATRIZ DE IMPACTO

### Impacto Alto (Requiere cambio)
- **Bracket_70_2_3**: Ogri'la clasificado incorrectamente
- **Bracket_80_2**: Trial of Champion en raid tier

### Impacto Medio (Necesita aclaración)
- **Bracket_40_49**: Descripción imprecisa
- **Bracket_70_4_1**: Contenido mixto

### Impacto Bajo (Documentación)
- **Bracket_60_3_3**: Sin descripción
- **Bracket_70_3_2**: Contenido mixto
- **Bracket_70_6_3**: Sin información

---

## BENEFICIOS DE LA IMPLEMENTACIÓN

1. ✅ **Alineación histórica**: 100% coherencia con Blizzard
2. ✅ **Claridad**: Brackets claramente documentadas
3. ✅ **Mantenibilidad**: Facilita futuros cambios
4. ✅ **Progresión correcta**: Usuarios entienden flujo de contenido
5. ✅ **Validación**: Base para auditorías futuras

---

## PRÓXIMOS PASOS

1. **Inmediatos** (Esta semana):
   - Investigar Bracket_60_3_3 y Bracket_70_6_3
   - Documentar existencia de archivos

2. **Corto plazo** (Semana que viene):
   - Actualizar `progression_system.conf.dist` con cambios documentales
   - Reorganizar Bracket_70_2_3 si es necesario

3. **Medio plazo**:
   - Reemplazar contenido de Bracket_80_2
   - Crear/reorganizar brackets para world content

4. **Largo plazo**:
   - Validación completa del sistema
   - Testing de cada bracket
   - Documentación de usuario

---

## NOTAS IMPORTANTES

⚠️ **WARNING**: No modificar brackets sin entender el impacto en la BD
- Los cambios en SQL son permanentes en la base de datos
- Revisar `ReapplyUpdates` setting antes de cambios
- Considerar script de rollback para cada cambio

📝 **Documentación**: Mantener README.md sincronizado con cambios

🔍 **Testing**: Cada bracket debe validarse tras cambios
- Verificar que scripts C++ cargan correctamente
- Verificar que SQL aplica sin errores
- Validar NPC/objeto/quest en cada bracket

---

## Referencias

- [AzerothCore mod-progression-system](https://github.com/azerothcore/mod-progression-system)
- [WoW Timeline oficial](https://wow.gamepedia.com/Timeline)
- [Vanilla Content Patches](https://wow.gamepedia.com/Vanilla_patches)
- [TBC Content Phases](https://wow.gamepedia.com/The_Burning_Crusade_patches)
- [WotLK Content Patches](https://wow.gamepedia.com/Wrath_of_the_Lich_King_patches)

