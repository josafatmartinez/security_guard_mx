# 🚀 Workflow para Security Guard MX

Este documento describe un flujo de trabajo ligero para un solo desarrollador, diseñado para mantener un proceso organizado y eficiente.

## 📋 Kanban Lite

Utilizamos un tablero Kanban simplificado con tres columnas:

- **📝 To Do**: Tareas que aún no se han comenzado
- **⏳ In Progress**: Tareas en las que se está trabajando actualmente
- **✅ Done**: Tareas completadas

El objetivo es mantener como máximo 2-3 tareas en "In Progress" para evitar el cambio de contexto excesivo.

## 🔄 Ciclo Ship-Ask-Show

Para cada tarea seguimos este ciclo:

1. **🚢 Ship**: Completa la tarea y sube los cambios
   - Implementa la funcionalidad
   - Escribe pruebas necesarias
   - Realiza un commit y push

2. **❓ Ask**: Realiza una auto-revisión crítica
   - ¿La implementación resuelve realmente el problema?
   - ¿Hay casos límite no cubiertos?
   - ¿El código es mantenible y sigue los estándares del proyecto?

3. **👀 Show**: Documenta y demuestra
   - Actualiza la documentación si es necesario
   - Agrega un comentario al issue describiendo lo implementado
   - Si aplica, incluye capturas de pantalla o videos breves de la funcionalidad

## 🌿 Git Flow Simple

Seguimos un flujo de Git simplificado:

```
main (producción) ← feature branches
```

### Reglas:

1. **Branch principal**: `main` siempre debe estar en estado estable y deployable
2. **Feature branches**: Crear desde `main` con el formato `feature/nombre-descriptivo`
   - Para bugs: `fix/descripcion-del-bug`
   - Para mejoras: `enhancement/descripcion-mejora`
3. **Commits**: Usar mensajes claros y descriptivos siguiendo el formato:
   ```
   [TIPO] Breve descripción (máx. 50 caracteres)

   - Detalles adicionales si son necesarios
   - Otro detalle

   Ref: #numero-de-issue
   ```
   Donde TIPO puede ser: FEAT, FIX, DOC, TEST, REFACTOR, STYLE, etc.

4. **Pull Requests**: Crear PR para integrar los cambios a `main`
   - Utilizar la plantilla de PR disponible
   - Realizar auto-revisión antes de solicitar merge

5. **Merge a main**: Preferir "Squash and merge" para mantener un historial limpio

## 🛠️ Gestión de Issues

Utilizamos issues de GitHub para seguimiento de tareas:

1. Crear issues específicos y bien definidos
2. Asignar etiquetas adecuadas (bug, enhancement, task, etc.)
3. Vincular issues a los PR correspondientes
4. Cerrar issues automáticamente desde commits con "Closes #X"

La creación de issues se puede automatizar con el script disponible en `/scripts/create_issue.sh`

## 📊 Revisión y Retrospectiva

Al final de cada semana:
1. Revisar todas las tareas completadas
2. Identificar áreas de mejora en el proceso
3. Ajustar el workflow según sea necesario
