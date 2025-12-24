# Guía Técnica de Implementación - Paso a Paso

## Fase 1: Investigación y Auditoría

### Paso 1.1: Auditar Bracket_60_3_3

**Objetivo**: Determinar exactamente qué contiene este bracket

```powershell
# Ver estructura
Get-ChildItem -Path "src/Bracket_60_3_3" -Recurse

# Leer el loader
Get-Content "src/Bracket_60_3_3/Bracket_60_3_3_loader.cpp"

# Contar archivos SQL
Get-ChildItem -Path "src/Bracket_60_3_3/sql" -Recurse -File
```

**Resultado esperado**:
- Si solo tiene `AddSC_temple_of_ahn_qiraj_tuning()`: Es solo tuning, puede ser documentado o eliminado
- Si tiene SQL: Verificar si es contenido nuevo o solo ajustes

**Acción**:
- ✅ Si es tuning: Documentar como comentario en config.dist
- ❌ Si es redundante: Considerar eliminar
- ➕ Si es contenido: Renombrar con descripción clara

---

### Paso 1.2: Auditar Bracket_70_2_3

**Objetivo**: Verificar contenido de Ogri'la

```powershell
# Ver estructura
Get-ChildItem -Path "src/Bracket_70_2_3" -Recurse

# Leer el loader  
Get-Content "src/Bracket_70_2_3/Bracket_70_2_3_loader.cpp"

# Ver SQL
Get-ChildItem -Path "src/Bracket_70_2_3/sql/world" -File
```

**Resultado esperado**:
- Archivos SQL relacionados con Ogri'la
- Scripts de quests/NPCs de Ogri'la

**Acción recomendada**:
1. Copiar contenido a `src/Bracket_70_6_1/` (Isle of Quel'Danas)
2. Actualizar referencias en loader
3. Actualizar config.dist

---

### Paso 1.3: Auditar Bracket_70_6_3

**Objetivo**: Determinar si existe contenido o está vacío

```powershell
# Ver estructura
Get-ChildItem -Path "src/Bracket_70_6_3" -Recurse

# Contar archivos
$itemCount = @(Get-ChildItem -Path "src/Bracket_70_6_3" -Recurse -File).Count
Write-Host "Total files: $itemCount"
```

**Resultado esperado**:
- Si está vacío (0-1 archivo): Eliminar referencia de config.dist
- Si tiene contenido: Documentar propósito

---

## Fase 2: Actualización de Configuración

### Paso 2.1: Actualizar conf/progression_system.conf.dist

**Cambio 1 - Bracket_40_49 (Línea ~51)**

```diff
- # Blackrock Depths, Dire Maul, Scholomance, Stratholme 
+ # World Dungeons: Dire Maul (36-48), BRD (54-60), Scholomance (60), Stratholme (60)
ProgressionSystem.Bracket_40_49   = 0
```

**Cambio 2 - Bracket_60_3_3 (Después de Bracket_60_3_2)**

```diff
# AQ40
ProgressionSystem.Bracket_60_3_2  = 0
+ # AQ Post-Content Adjustments (if applicable)
+ ProgressionSystem.Bracket_60_3_3  = 0
```

**Cambio 3 - Bracket_70_2_3 (Línea ~90)**

```diff
- # Ogri'la
+ # World Content Enhancement (Ogri'la, Blade's Edge Mountains dailies)
+ # Note: Ogri'la dailies should ideally be in Bracket_70_6_1
ProgressionSystem.Bracket_70_2_3  = 0
```

**Cambio 4 - Bracket_70_3_2 (Línea ~104)**

```diff
- # The Eye, Sha'tari Skyguard
+ # The Eye (Raid Tier 2) + Sha'tari Skyguard (World Content)
ProgressionSystem.Bracket_70_3_2  = 0
```

**Cambio 5 - Bracket_70_4_1 (Línea ~108)**

```diff
- # Battle For Mount Hyjal, Arena Season 2, Netherwing
+ # Battle For Mount Hyjal (Raid Tier 3), Arena Season 2, Netherwing Dailies
ProgressionSystem.Bracket_70_4_1  = 0
```

**Cambio 6 - Bracket_70_6_3 (Línea ~128)**

```diff
# Sunwell Plateau, Arena Season 4
ProgressionSystem.Bracket_70_6_2  = 0
+ # TBC Final Phase Adjustments (if applicable)
+ ProgressionSystem.Bracket_70_6_3  = 0
```

**Cambio 7 - Bracket_80_2 (IMPORTANTE - Línea ~138)**

```diff
- # Ulduar, Trial of the Champion, Arena Season 6
+ # Ulduar (Raid Tier 1), Naxxramas 80, Eye of Eternity, Arena Season 6
ProgressionSystem.Bracket_80_2    = 0
```

**Cambio 8 - Bracket_80_3**

```diff
- # Onyxia's Lair, Trial of The Crusader, Arena Season 7
+ # Trial of the Crusader (Raid Tier 2), Onyxia's Lair 80, Arena Season 7
ProgressionSystem.Bracket_80_3    = 0
```

---

### Paso 2.2: Actualizar archivos de loaders (si es necesario)

**Para Bracket_70_2_3** (Si se mueve a 70_6_1):

```bash
# Copiar contenido
cp -r src/Bracket_70_2_3/sql/* src/Bracket_70_6_1/sql/
cp -r src/Bracket_70_2_3/scripts/* src/Bracket_70_6_1/scripts/

# Actualizar loader de 70_6_1
# Añadir includes del loader de 70_2_3
```

---

## Fase 3: Validación

### Paso 3.1: Validar sintaxis de configuración

```bash
# Buscar errores de sintaxis
grep -n "ProgressionSystem.Bracket" conf/progression_system.conf.dist | wc -l
# Debe haber 38 brackets
```

### Paso 3.2: Validar loaders C++

```bash
# Verificar que todos los loaders se compilan
cd src/
grep -r "AddBracket_" *.cpp | wc -l
# Debe haber referencias a todos los brackets
```

### Paso 3.3: Validar SQL

```bash
# Verificar que todos los SQL son válidos
for bracket in Bracket_*; do
    echo "Validating $bracket..."
    find "$bracket/sql" -name "*.sql" -exec grep -l "ERROR" {} \;
done
```

---

## Fase 4: Testing Post-Cambios

### Paso 4.1: Testing de Bracket_40_49

```sql
-- Verificar que BRD, Dire Maul, Scholomance, Stratholme cargan
SELECT * FROM dungeon_access_requirements 
WHERE dungeon_access_id IN (SELECT id FROM dungeon_access WHERE name LIKE 'Bracket_40_49');
```

### Paso 4.2: Testing de Bracket_70_2_3 (si se reorganiza)

```sql
-- Verificar que Ogri'la content está accesible
SELECT * FROM quest_template 
WHERE (title LIKE '%Ogri%' OR id IN (...))
AND patch_version = 'Bracket_70_2_3' OR patch_version = 'Bracket_70_6_1';
```

### Paso 4.3: Testing de Bracket_80_2

```sql
-- Verificar bosses y encounters
SELECT * FROM creature WHERE (name LIKE '%Algalon%' OR name LIKE '%Malygos%')
AND patch_version = 'Bracket_80_2';
```

---

## Fase 5: Actualización de Documentación

### Paso 5.1: Actualizar README.md

Añadir sección:

```markdown
## Bracket Progression Timeline

### Vanilla (1-60)
- **Bracket_1_19-40_49**: Dungeons
- **Bracket_50_59_1-59_2**: UBRS & Attunement
- **Bracket_60_1_1 to 60_3_3**: Raids (MC → AQ40)

### The Burning Crusade (61-70)
- **Bracket_61_64 to 70_1_2**: Dungeons & Heroics
- **Bracket_70_2_1 to 70_6_2**: Raids & World Content
- **Bracket_70_6_3**: TBC Final Adjustments (if applicable)

### Wrath of the Lich King (71-80)
- **Bracket_71_74 to 80_1_2**: Dungeons & Heroics
- **Bracket_80_2 to 80_4_2**: Raids
```

### Paso 5.2: Crear documento BRACKETS.md

```markdown
# Bracket Reference Guide

[Aquí documentar cada bracket con:
- Nombre oficial de Blizzard
- Nivel recomendado
- Fecha de lanzamiento histórica
- Contenido específico
- SQL modifications
- C++ script changes]
```

---

## Rollback Plan

Si algo sale mal:

### Opción 1: Revertir configuración
```bash
git checkout conf/progression_system.conf.dist
```

### Opción 2: Revertir bases de datos
```sql
-- Limpiar progression entries
DELETE FROM updates WHERE name LIKE '%progression%';

-- Ejecutar revert scripts si existen
-- (La mayoría de cambios requieren SQL manual para revertir)
```

### Opción 3: Reset completo (Nuclear option)
```bash
# Restaurar backup original
mysqldump -u user -p database > backup_$(date +%Y%m%d).sql
mysql -u user -p database < original_backup.sql
```

---

## Checklist de Implementación

- [ ] Paso 1.1: Auditar Bracket_60_3_3
- [ ] Paso 1.2: Auditar Bracket_70_2_3
- [ ] Paso 1.3: Auditar Bracket_70_6_3
- [ ] Paso 2.1: Actualizar conf.dist (8 cambios)
- [ ] Paso 2.2: Actualizar loaders si necesario
- [ ] Paso 3.1: Validar sintaxis
- [ ] Paso 3.2: Validar C++
- [ ] Paso 3.3: Validar SQL
- [ ] Paso 4.1-4.3: Testing completo
- [ ] Paso 5.1-5.2: Documentación
- [ ] Commit a git con mensaje descriptivo
- [ ] Comunicar cambios a equipo/community

---

## Comandos Útiles

```bash
# Buscar todos los brackets
grep -r "AddBracket_" src/ | grep -o "AddBracket_[0-9a-zA-Z_]*" | sort -u

# Contar líneas de código por bracket
for dir in src/Bracket_*/; do
    echo "$dir: $(find "$dir" -name "*.cpp" -o -name "*.sql" | xargs wc -l | tail -1)"
done

# Validar que no hay conflictos
grep -r "TODO\|FIXME\|BUG\|XXX" src/ | grep -i "bracket\|progression"

# Generar reporte de cambios
git diff conf/progression_system.conf.dist > bracket_changes.diff
```

---

## Recursos

- [Git branching strategy](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows)
- [AzerothCore DBUpdater documentation](https://docs.azerothcore.org/en/latest/development/)
- [SQL formatting guidelines](https://dev.mysql.com/doc/refman/8.0/en/statement-syntax.html)
- [C++ coding standards for AzerothCore](https://github.com/azerothcore/azerothcore-wotlk/blob/master/CONTRIBUTING.md)

