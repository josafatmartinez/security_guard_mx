#!/bin/bash

# Script para hacer auto-revisión de código siguiendo el ciclo Ship-Ask-Show
# Uso: ./review.sh [branch-name]

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Determinar la rama a revisar
if [ -z "$1" ]; then
  BRANCH=$(git branch --show-current)
else
  BRANCH="$1"
fi

echo -e "${BLUE}=== Auto-revisión de código: $BRANCH ===${NC}"
echo

# 1. SHIP - Verificar el estado del código
echo -e "${PURPLE}🚢 SHIP - Verificación de código${NC}"
echo -e "${YELLOW}Archivos modificados:${NC}"
git diff --name-status main...$BRANCH

echo
echo -e "${YELLOW}Estadísticas de cambios:${NC}"
git diff --stat main...$BRANCH | tail -n1

# Verificar si hay tests
DART_FILES_CHANGED=$(git diff --name-only main...$BRANCH | grep "\.dart$" | wc -l)
TEST_FILES_CHANGED=$(git diff --name-only main...$BRANCH | grep "_test\.dart$" | wc -l)

if [ $DART_FILES_CHANGED -gt 0 ] && [ $TEST_FILES_CHANGED -eq 0 ]; then
  echo -e "\n${RED}⚠️  No se detectaron cambios en archivos de prueba.${NC}"
  echo -e "${YELLOW}Considera agregar pruebas para los cambios realizados.${NC}"
fi

# 2. ASK - Preguntas para auto-revisión
echo -e "\n${PURPLE}❓ ASK - Auto-revisión crítica${NC}"
echo -e "${YELLOW}Por favor, responde estas preguntas:${NC}"

questions=(
  "¿La implementación resuelve realmente el problema planteado?"
  "¿Se cubren todos los casos límite?"
  "¿El código sigue los estándares del proyecto?"
  "¿Se han documentado adecuadamente los cambios?"
  "¿Se han añadido pruebas suficientes?"
  "¿Hay código duplicado o innecesario?"
)

for i in "${!questions[@]}"; do
  read -p "${BLUE}$((i+1)). ${questions[$i]} ${NC}(s/n): " answer
  if [[ "$answer" != "s" && "$answer" != "S" ]]; then
    echo -e "${RED}⚠️  Revisa este aspecto antes de continuar.${NC}"
  fi
done

# 3. SHOW - Preparar demostración
echo -e "\n${PURPLE}👀 SHOW - Preparación de demostración${NC}"
echo -e "${YELLOW}¿Quieres crear una nota de demostración para este cambio? (s/n):${NC} "
read demo_answer

if [[ "$demo_answer" == "s" || "$demo_answer" == "S" ]]; then
  # Extraer número de issue del nombre de la rama
  ISSUE_NUMBER=$(echo $BRANCH | grep -oE '[0-9]+' | head -1)
  DEMO_FILE="docs/demos/demo-issue-$ISSUE_NUMBER.md"

  # Crear directorio si no existe
  mkdir -p "$(dirname "$DEMO_FILE")"

  # Crear archivo de demostración
  cat > "$DEMO_FILE" << EOF
# Demostración - Issue #$ISSUE_NUMBER

## Cambios implementados
<!-- Describe brevemente los cambios realizados -->

## Capturas de pantalla
<!-- Añade capturas de pantalla si aplica -->

## Cómo probar
<!-- Indica los pasos para probar esta funcionalidad -->
1.
2.
3.

## Notas adicionales
<!-- Cualquier información adicional relevante -->

EOF

  echo -e "${GREEN}✅ Archivo de demostración creado en: $DEMO_FILE${NC}"
  echo -e "${YELLOW}Completa el archivo con la información de tu implementación.${NC}"
fi

echo
echo -e "${BLUE}=== Revisión completada ===${NC}"
echo -e "${GREEN}Recuerda actualizar el estado del issue una vez que estés conforme con los cambios.${NC}"
