#!/bin/bash

# Script para cambiar el estado de un issue en el flujo Kanban
# Uso: ./kanban.sh [número-issue] [estado]
# Estados: todo, in-progress, done

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Comprobar si GitHub CLI está instalado
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI no está instalado.${NC}"
    echo -e "Instálalo con: ${YELLOW}brew install gh${NC}"
    exit 1
fi

# Verificar argumentos
if [ "$#" -ne 2 ]; then
    echo -e "${RED}Error: Número de argumentos incorrecto.${NC}"
    echo -e "${YELLOW}Uso: ./kanban.sh [número-issue] [estado]${NC}"
    echo -e "${YELLOW}Estados disponibles: todo, in-progress, done${NC}"
    exit 1
fi

ISSUE_NUMBER=$1
STATUS=$2

# Validar estado
case $STATUS in
    todo)
        LABELS="to-do"
        REMOVE_LABELS="in-progress,done"
        STATUS_EMOJI="📝"
        ;;
    in-progress|progress)
        LABELS="in-progress"
        REMOVE_LABELS="to-do,done"
        STATUS_EMOJI="⏳"
        ;;
    done)
        LABELS="done"
        REMOVE_LABELS="to-do,in-progress"
        STATUS_EMOJI="✅"
        ;;
    *)
        echo -e "${RED}Error: Estado '$STATUS' no reconocido.${NC}"
        echo -e "${YELLOW}Estados disponibles: todo, in-progress, done${NC}"
        exit 1
        ;;
esac

# Cambiar etiquetas
echo -e "${BLUE}Cambiando estado del issue #$ISSUE_NUMBER a $STATUS_EMOJI $STATUS...${NC}"

# Eliminar etiquetas antiguas
if [ -n "$REMOVE_LABELS" ]; then
    gh issue edit "$ISSUE_NUMBER" --remove-label "$REMOVE_LABELS" 2>/dev/null
fi

# Añadir nueva etiqueta
gh issue edit "$ISSUE_NUMBER" --add-label "$LABELS"

# Verificar que el issue existe y mostrar estado
if gh issue view "$ISSUE_NUMBER" --json number,title,state,labels >/dev/null 2>&1; then
    ISSUE_INFO=$(gh issue view "$ISSUE_NUMBER" --json number,title,state,labels)
    ISSUE_TITLE=$(echo $ISSUE_INFO | jq -r '.title')
    ISSUE_STATE=$(echo $ISSUE_INFO | jq -r '.state')

    echo -e "${GREEN}✅ Issue #$ISSUE_NUMBER actualizado correctamente${NC}"
    echo -e "${BLUE}Título: ${NC}$ISSUE_TITLE"
    echo -e "${BLUE}Estado: ${NC}$ISSUE_STATE ($STATUS_EMOJI $STATUS)"

    # Añadir comentario al issue
    COMMENT="Estado cambiado a **$STATUS_EMOJI $STATUS**"
    gh issue comment "$ISSUE_NUMBER" --body "$COMMENT"
else
    echo -e "${RED}Error: El issue #$ISSUE_NUMBER no existe o no tienes permisos para acceder a él.${NC}"
fi
