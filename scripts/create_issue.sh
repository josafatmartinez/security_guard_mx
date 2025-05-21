#!/bin/bash

# Script para crear issues en GitHub desde la línea de comandos
# Requisito: GitHub CLI (gh) debe estar instalado y configurado
# Instalar con: brew install gh (en macOS)
# Configurar con: gh auth login

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Comprobar si GitHub CLI está instalado
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI no está instalado.${NC}"
    echo -e "Instálalo con: ${YELLOW}brew install gh${NC}"
    echo -e "Después configúralo con: ${YELLOW}gh auth login${NC}"
    exit 1
fi

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}=== Security Guard MX - Creador de Issues ===${NC}"
    echo
    echo -e "Uso: ${YELLOW}./create_issue.sh [opciones]${NC}"
    echo
    echo -e "Opciones:"
    echo -e "  ${GREEN}-t, --type TYPE${NC}      Tipo de issue (bug, feature, task)"
    echo -e "  ${GREEN}-n, --title TITLE${NC}    Título del issue"
    echo -e "  ${GREEN}-d, --desc DESC${NC}      Descripción del issue"
    echo -e "  ${GREEN}-l, --labels LABELS${NC}  Etiquetas separadas por comas"
    echo -e "  ${GREEN}-h, --help${NC}           Muestra este mensaje de ayuda"
    echo
    echo -e "Ejemplos:"
    echo -e "  ${YELLOW}./create_issue.sh --type bug --title \"La app se cierra al iniciar\" --desc \"En dispositivos Android 11 la app se cierra inesperadamente\"${NC}"
    echo -e "  ${YELLOW}./create_issue.sh --type feature --title \"Añadir notificaciones push\" --labels \"enhancement,high-priority\"${NC}"
}

# Parámetros por defecto
TYPE=""
TITLE=""
DESC=""
LABELS=""

# Procesar parámetros
while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--type)
            TYPE="$2"
            shift 2
            ;;
        -n|--title)
            TITLE="$2"
            shift 2
            ;;
        -d|--desc)
            DESC="$2"
            shift 2
            ;;
        -l|--labels)
            LABELS="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}Error: Opción desconocida $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Validar tipo
if [[ -z "$TYPE" ]]; then
    echo -e "${YELLOW}Selecciona el tipo de issue:${NC}"
    echo -e "1) ${RED}Bug${NC}"
    echo -e "2) ${GREEN}Feature${NC}"
    echo -e "3) ${BLUE}Task${NC}"
    read -p "Opción (1-3): " type_option

    case $type_option in
        1) TYPE="bug" ;;
        2) TYPE="feature" ;;
        3) TYPE="task" ;;
        *) echo -e "${RED}Opción inválida. Usando 'task' por defecto.${NC}"; TYPE="task" ;;
    esac
fi

# Preparar prefijo del título según el tipo
case $TYPE in
    bug)
        PREFIX="[BUG]"
        if [[ -z "$LABELS" ]]; then
            LABELS="bug"
        fi
        ;;
    feature)
        PREFIX="[FEAT]"
        if [[ -z "$LABELS" ]]; then
            LABELS="enhancement"
        fi
        ;;
    task)
        PREFIX="[TASK]"
        if [[ -z "$LABELS" ]]; then
            LABELS="task"
        fi
        ;;
    *)
        echo -e "${RED}Tipo de issue no válido: $TYPE${NC}"
        echo "Usa 'bug', 'feature' o 'task'"
        exit 1
        ;;
esac

# Solicitar título si no se proporcionó
if [[ -z "$TITLE" ]]; then
    read -p "Título del issue: " TITLE
fi

# Añadir prefijo si no está ya incluido
if [[ ! $TITLE == $PREFIX* ]]; then
    TITLE="$PREFIX $TITLE"
fi

# Solicitar descripción si no se proporcionó
if [[ -z "$DESC" ]]; then
    echo "Introduce la descripción (presiona Enter, luego Ctrl+D cuando termines):"
    DESC=$(cat)
fi

# Mostrar resumen antes de crear
echo -e "${PURPLE}=== Resumen del Issue ===${NC}"
echo -e "${BLUE}Tipo:${NC} $TYPE"
echo -e "${BLUE}Título:${NC} $TITLE"
echo -e "${BLUE}Etiquetas:${NC} $LABELS"
echo -e "${BLUE}Descripción:${NC}"
echo "$DESC"
echo

# Confirmar creación
read -p "¿Crear este issue? (s/N): " confirm
if [[ ! $confirm =~ ^[Ss]$ ]]; then
    echo -e "${YELLOW}Operación cancelada.${NC}"
    exit 0
fi

# Crear el issue usando gh cli
if gh issue create --title "$TITLE" --body "$DESC" --label "$LABELS"; then
    echo -e "${GREEN}¡Issue creado exitosamente!${NC}"
else
    echo -e "${RED}Error al crear el issue. Asegúrate de que GitHub CLI esté configurado correctamente.${NC}"
    exit 1
fi
