# Análisis de Progresión del Módulo - Validación con Blizzard

## Estructura Actual del Módulo

El módulo tiene 38 brackets (definido en ProgressionSystem.h):
1. Bracket_0
2. Bracket_1_19
3. Bracket_20_29
4. Bracket_30_39
5. Bracket_40_49
6. Bracket_50_59_1
7. Bracket_50_59_2
8. Bracket_60_1_1
9. Bracket_60_1_2
10. Bracket_60_2_1
11. Bracket_60_2_2
12. Bracket_60_3_1
13. Bracket_60_3_2
14. Bracket_60_3_3
15. Bracket_61_64
16. Bracket_65_69
17. Bracket_70_1_1
18. Bracket_70_1_2
19. Bracket_70_2_1
20. Bracket_70_2_2
21. Bracket_70_2_3
22. Bracket_70_3_1
23. Bracket_70_3_2
24. Bracket_70_4_1
25. Bracket_70_4_2
26. Bracket_70_5
27. Bracket_70_6_1
28. Bracket_70_6_2
29. Bracket_70_6_3
30. Bracket_71_74
31. Bracket_75_79
32. Bracket_80_1_1
33. Bracket_80_1_2
34. Bracket_80_2
35. Bracket_80_3
36. Bracket_80_4_1
37. Bracket_80_4_2
38. Bracket_Custom

## Análisis por Era

### VANILLA (1-60)

**Bracket_0**: Level 0
- No descripción en config
- Propósito: Probablemente pre-launch o nivel 1

**Bracket_1_19**: Shadowfang Keep, Deadmines, Wailing Caverns, Blackfathom Deeps, Ragefire Chasm
- Dungeons de nivel 10-20
- ✅ CORRECTO: Estos son los primeros dungeons de Vanilla

**Bracket_20_29**: Stormwind Stockades, Razorfen Kraul, Gnomeregan
- Dungeons de nivel 20-29
- ✅ CORRECTO: Progresión adecuada

**Bracket_30_39**: Uldaman, Razorfen Downs, Scarlet Monastery
- Dungeons de nivel 30-39
- ✅ CORRECTO: Progresión adecuada

**Bracket_40_49**: Blackrock Depths, Dire Maul, Scholomance, Stratholme
- Dungeons de nivel 40-49 / World Dungeons
- ⚠️ NOTA: BRD es 54-60, Dire Maul es 36-48, Scholomance 60-60, Stratholme 60-60
- 📌 Problema: Estos dungeons tienen nivel sugerido más alto que 40-49

**Bracket_50_59_1**: Blackrock Spire - Attunement requirement
- Pre-requisitos para UBRS
- ✅ CORRECTO: Separación de attunement

**Bracket_50_59_2**: Blackrock Spire
- Upper Blackrock Spire
- ✅ CORRECTO: Después de attunement

### VANILLA RAIDS (60)

**Bracket_60_1_1**: Molten Core
- Primera raid tier de Vanilla
- ✅ CORRECTO: Primer raid

**Bracket_60_1_2**: Onyxia's Lair
- Raid 40 hombres
- ✅ CORRECTO: Simultáneo con MC

**Bracket_60_2_1**: Blackwing Lair
- Tercer tier de raids Vanilla
- ✅ CORRECTO: Después de MC/Onyxia

**Bracket_60_2_2**: Zul'Gurub
- 20-man raid tier
- ✅ CORRECTO: Tier 2 en progresión

**Bracket_60_3_1**: AQ20
- 20-man raid (Temple of Ahn'Qiraj)
- ✅ CORRECTO: Tier 3

**Bracket_60_3_2**: AQ40
- 40-man raid (Temple of Ahn'Qiraj)
- ✅ CORRECTO: Tier 3

**Bracket_60_3_3**: ??? (Ver scripts de Temple of Ahn'Qiraj tuning)
- ⚠️ POSIBLE PROBLEMA: Sin descripción clara
- Parece ser ajustes de AQ, no un tier separado
- 📌 Posible redundancia o ajuste de dificultad

### THE BURNING CRUSADE (61-70)

**Bracket_61_64**: 61-64 Dungeons
- Primeros dungeons de TBC
- Dungeons: Hellfire Ramp/Blood Furnace, Slave Pens, Underbog, The Mechanar, etc.
- ✅ CORRECTO

**Bracket_65_69**: 65-69 Dungeons
- Dungeons avanzados de TBC
- Dungeons: The Arcatraz, Shadow Labyrinth, etc.
- ✅ CORRECTO

**Bracket_70_1_1**: Level 70, Flying, Normal Dungeons
- Chegada a nivel máximo
- Primeros dungeons a nivel cap (no heroicos)
- ✅ CORRECTO

**Bracket_70_1_2**: Level 70, Heroics
- Versiones heroicas de dungeons
- ✅ CORRECTO

**Bracket_70_2_1**: Gruul's Lair, Magtheridon's Lair, Arena Season 1
- Primeros 25-man raids de TBC
- ✅ CORRECTO: Tier 1 de TBC

**Bracket_70_2_2**: Karazhan
- 10-man raid (similar a Zul'Gurub)
- ✅ CORRECTO: Progresión alternativa

**Bracket_70_2_3**: Ogri'la
- Dailies/World Content
- ⚠️ PROBLEMA: Ogri'la no es un raid, es world content
- 📌 Debería estar en Bracket_70_5 (Isle of Quel'Danas) o combinado

**Bracket_70_3_1**: Serpentshrine Cavern
- 25-man raid Tier 2
- ✅ CORRECTO

**Bracket_70_3_2**: The Eye, Sha'tari Skyguard
- 25-man raid Tier 2 (The Eye), world content (Sha'tari Skyguard)
- ⚠️ MEZCLA: Raid + World Content en mismo bracket

**Bracket_70_4_1**: Battle For Mount Hyjal, Arena Season 2, Netherwing
- 25-man raid Tier 3
- Arenas y world content (Netherwing)
- ✅ CORRECTO

**Bracket_70_4_2**: Black Temple
- 25-man raid Tier 4
- ✅ CORRECTO

**Bracket_70_5**: Zul'Aman, Arena Season 3
- 10-man raid (similar a Karazhan)
- ✅ CORRECTO

**Bracket_70_6_1**: Isle of Quel'Danas, Magister's Terrace
- World content + 5-man dungeon
- ✅ CORRECTO

**Bracket_70_6_2**: Sunwell Plateau, Arena Season 4
- Última raid de TBC Tier 5
- ✅ CORRECTO

**Bracket_70_6_3**: ??? (No especificado en config)
- ⚠️ PROBLEMA: Sin descripción
- Posiblemente para ajustes finales de TBC

### WRATH OF THE LICH KING (71-80)

**Bracket_71_74**: 71-74 Dungeons
- Primeros dungeons de WotLK
- ✅ CORRECTO

**Bracket_75_79**: 75-79 Dungeons
- Dungeons avanzados de WotLK
- ✅ CORRECTO

**Bracket_80_1_1**: Normal WotLK Dungeons
- Dungeons a nivel cap
- ✅ CORRECTO

**Bracket_80_1_2**: Heroic WotLK Dungeons
- Versiones heroicas
- ✅ CORRECTO

**Bracket_80_2**: Ulduar, Trial of the Champion, Arena Season 6
- Primera raid tier de WotLK
- ⚠️ MEZCLA: Raid principal + Trial (side content)
- 📌 Trial of the Champion es 5-man, no raid

**Bracket_80_3**: Onyxia's Lair, Trial of The Crusader, Arena Season 7
- Trial of the Crusader es Tier 2 raid
- ✅ CORRECTO

**Bracket_80_4_1**: Icecrown Citadel, ICC Dungeons, Arena Season 8
- Última raid tier de WotLK
- ✅ CORRECTO

**Bracket_80_4_2**: Ruby Sanctum
- Raid adicional post-ICC
- ✅ CORRECTO

## PROBLEMAS IDENTIFICADOS

### 1. **Bracket_60_3_3**: Sin descripción clara
   - Parece ser solo ajustes de AQ
   - Podría fusionarse con Bracket_60_3_2 o eliminarse

### 2. **Bracket_70_2_3 (Ogri'la)**: Misclassification
   - Ogri'la es world content, no un tier de raid
   - Debería estar en Bracket_70_6_1 (Isle of Quel'Danas)

### 3. **Bracket_70_3_2**: Mezcla de raid + world content
   - The Eye es raid
   - Sha'tari Skyguard es world content/dailies
   - Podrían separarse

### 4. **Bracket_70_4_1**: Mezcla de raid + world content + arenas
   - Battle For Mount Hyjal es raid principal
   - Netherwing es world content
   - Arena Season 2 es PvP

### 5. **Bracket_80_2**: Trial of the Champion en raid tier
   - Trial of the Champion es 5-man dungeon, no raid
   - Debería estar en Bracket_80_1_2

### 6. **Bracket_70_6_3**: Sin descripción
   - ⚠️ Falta información

### 7. **Bracket_40_49**: Nivel sugerido inconsistente
   - BRD, Scholomance y Stratholme son nivel 54-60
   - El rango 40-49 es incorrecto

## RECOMENDACIONES

1. **Documentar claramente** qué contiene cada bracket
2. **Separar world content** de raid tiers
3. **Revisar niveles sugeridos** para cada dungeon
4. **Verificar orden de progresión** vs. timeline histórica de Blizzard
5. **Unificar brackets** donde haya redundancia (Bracket_60_3_3)

## Cronología Histórica de WoW

### Vanilla
- **Phase 1**: MC, Onyxia (Noviembre 2004)
- **Phase 2**: BWL, Darkmoon Faire (Diciembre 2005)
- **Phase 3**: AQ20, AQ40, Dragons of Nightmare (Enero 2006)
- **Phase 5**: Silithus, AQ opening (Enero 2006)
- **Phase 6**: Naxx, Dragons (Junio 2006)

### The Burning Crusade
- **Phase 1**: Gruul, Magtheridon, Karazhan (Enero 2007)
- **Phase 2**: SSC, TK (Mayo 2007)
- **Phase 3**: Hyjal, BT (Agosto 2007)
- **Phase 4**: Zul'Aman (Diciembre 2007)
- **Phase 5**: Isle of Quel'Danas, Sunwell (Marzo 2008)

### Wrath of the Lich King
- **Phase 1**: Naxx, EoE, OS (Noviembre 2008)
- **Phase 2**: Ulduar (Abril 2009)
- **Phase 3**: ToC (Agosto 2009)
- **Phase 4**: ICC (Diciembre 2009)
- **Phase 5**: RS (Diciembre 2009)
