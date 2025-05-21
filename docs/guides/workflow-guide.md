# 📋 Guía de Uso del Workflow

Esta guía explica cómo implementar el workflow ligero en el día a día.

## 🚀 Ciclo de Vida de una Tarea

### 1️⃣ Creación de la Tarea

Comienza creando un issue en GitHub:

```bash
# Usando el script
./scripts/create_issue.sh

# O manualmente desde GitHub
# https://github.com/tu-usuario/security_guard_mx/issues/new/choose
```

### 2️⃣ Desarrollo (Ciclo Ship-Ask-Show)

#### 🚢 Ship

1. Crear rama para la tarea:

```bash
# Si no existe automáticamente
git checkout main
git pull
git checkout -b feature/123-nombre-descriptivo
# (o fix/123-nombre-descriptivo para bugs)
```

2. Implementa los cambios necesarios
3. Realiza commits frecuentes y descriptivos:

```bash
git add .
git commit -m "[FEAT] Implementa nueva funcionalidad

- Agrega X componente
- Integra con Y servicio

Ref: #123"
```

4. Push de los cambios:

```bash
git push origin feature/123-nombre-descriptivo
```

#### ❓ Ask

Realiza auto-revisión de código con:

```bash
./scripts/review.sh
```

Esto te guiará por una serie de preguntas para verificar la calidad del código.

#### 👀 Show

1. Documenta los cambios realizados
2. Actualiza el estado del issue:

```bash
./scripts/kanban.sh 123 in-progress
```

3. Crea un Pull Request (automático o manual)

### 3️⃣ Integración

Una vez finalizada la revisión:

1. Completa el Pull Request
2. Realiza el merge a `main`
3. Actualiza el estado del issue:

```bash
./scripts/kanban.sh 123 done
```

## 📊 Gestión del Kanban

El tablero Kanban se gestiona con estos estados:

| Estado | Etiqueta | Descripción | Comando |
|--------|----------|-------------|---------|
| 📝 To Do | `to-do` | Tareas por hacer | `./scripts/kanban.sh 123 todo` |
| ⏳ In Progress | `in-progress` | Tareas en desarrollo | `./scripts/kanban.sh 123 in-progress` |
| ✅ Done | `done` | Tareas completadas | `./scripts/kanban.sh 123 done` |

## 🌿 Flujo Git Simplificado

```
main (producción)
 ↑
feature/123-nombre-descriptivo
```

1. Crear rama desde `main`
2. Desarrollar en la rama feature/fix
3. Crear PR y revisar código
4. Merge a `main` (preferiblemente con squash)
