#!/bin/bash

# Script para iniciar rápidamente una tarea del ciclo Ship-Ask-Show
# Uso: ./start_task.sh [tipo] [título-descriptivo]
# Donde tipo puede ser: feature, fix, task

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Verificar si hay suficientes argumentos
if [ "$#" -lt 1 ]; then
    echo -e "${YELLOW}Uso: ${NC}./start_task.sh [tipo] [título-descriptivo]"
    echo -e "${YELLOW}Tipos disponibles: ${NC}feature, fix, task"
    echo
    echo -e "Configurando interactivamente..."
    echo

    # Solicitar tipo
    echo -e "${BLUE}Selecciona el tipo de tarea:${NC}"
    echo -e "1) ${GREEN}Feature${NC} (nueva funcionalidad)"
    echo -e "2) ${RED}Fix${NC} (corrección de bug)"
    echo -e "3) ${YELLOW}Task${NC} (tarea general)"
    read -p "Opción (1-3): " type_option

    case $type_option in
        1) TASK_TYPE="feature" ;;
        2) TASK_TYPE="fix" ;;
        3) TASK_TYPE="task" ;;
        *) echo -e "${RED}Opción inválida. Usando 'feature' por defecto.${NC}"; TASK_TYPE="feature" ;;
    esac

    # Solicitar título
    read -p "Título descriptivo: " TASK_TITLE
else
    TASK_TYPE="$1"
    shift
    TASK_TITLE="$*"
fi

# Validar tipo de tarea
case $TASK_TYPE in
    feature|fix|task)
        # Tipo válido, continuar
        ;;
    *)
        echo -e "${RED}Tipo de tarea no válido: $TASK_TYPE${NC}"
        echo -e "Tipos disponibles: feature, fix, task"
        exit 1
        ;;
esac

# Crear issue en GitHub
echo -e "\n${PURPLE}=== Creando issue en GitHub ===${NC}"

case $TASK_TYPE in
    feature)
        ISSUE_TYPE="feature"
        TITLE_PREFIX="[FEAT]"
        ;;
    fix)
        ISSUE_TYPE="bug"
        TITLE_PREFIX="[BUG]"
        ;;
    task)
        ISSUE_TYPE="task"
        TITLE_PREFIX="[TASK]"
        ;;
esac

# Añadir prefijo al título si no está
if [[ ! $TASK_TITLE == $TITLE_PREFIX* ]]; then
    TASK_TITLE="$TITLE_PREFIX $TASK_TITLE"
fi

# Crear el issue
echo -e "${BLUE}Creando issue: ${NC}$TASK_TITLE"
./scripts/create_issue.sh --type "$ISSUE_TYPE" --title "$TASK_TITLE"

# Obtener el número del issue recién creado
sleep 1 # esperar a que GitHub registre el issue
ISSUE_NUMBER=$(gh issue list --limit 1 --json number --jq '.[0].number')

if [ -z "$ISSUE_NUMBER" ]; then
    echo -e "${RED}No se pudo obtener el número del issue. Creando rama sin referencia.${NC}"
    BRANCH_NAME="$TASK_TYPE/$(echo $TASK_TITLE | tr '[:upper:]' '[:lower:]' | sed 's/\[.*\]//g' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')"
else
    echo -e "${GREEN}Issue #$ISSUE_NUMBER creado correctamente.${NC}"
    BRANCH_NAME="$TASK_TYPE/$ISSUE_NUMBER-$(echo $TASK_TITLE | tr '[:upper:]' '[:lower:]' | sed 's/\[.*\]//g' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')"

    # Cambiar el estado del issue a in-progress
    ./scripts/kanban.sh "$ISSUE_NUMBER" in-progress
fi

# Crear rama Git
echo -e "\n${PURPLE}=== Configurando entorno de desarrollo ===${NC}"
echo -e "${BLUE}Creando rama: ${NC}$BRANCH_NAME"

git checkout main
git pull
git checkout -b "$BRANCH_NAME"

echo -e "\n${GREEN}✅ ¡Todo listo para empezar a trabajar!${NC}"
echo -e "${BLUE}Rama actual: ${NC}$BRANCH_NAME"
if [ -n "$ISSUE_NUMBER" ]; then
    echo -e "${BLUE}Issue: ${NC}#$ISSUE_NUMBER - $TASK_TITLE"
fi

echo -e "\n${PURPLE}=== Ciclo Ship-Ask-Show ===${NC}"
echo -e "${YELLOW}1. Ship: ${NC}Implementa la funcionalidad y haz commits regulares"
echo -e "${YELLOW}2. Ask: ${NC}Ejecuta ./scripts/review.sh para auto-revisar tu código"
echo -e "${YELLOW}3. Show: ${NC}Documenta y crea un Pull Request cuando termines"

echo -e "\n${GREEN}¡Buena suerte con tu tarea!${NC}"
