# 🛡️ Security Guard MX 🔍

✨ La app que revoluciona la manera de gestionar la seguridad! ✨

## 🔥 ¿De qué va esto? 🔥

Security Guard MX es LA SOLUCIÓN DEFINITIVA 💯 para el control de guardias de seguridad. Desarrollada con Flutter (¡sí, multiplataforma y súper cool! 🚀), esta app conecta a guardias y supervisores en tiempo real. ¿Cómo? Los supervisores dropean checkpoints en el mapa y los guardias hacen check-in escaneando QRs durante sus rondines. ¡No más papeleos ni reportes perdidos! 📱✨

## 🚀 Flujo de Trabajo

Este proyecto utiliza un flujo de trabajo ligero para desarrollador individual. Para más información, consulta:

- [Documento de Workflow](WORKFLOW.md) - Descripción detallada del flujo de trabajo
- [Plantillas de Issues](.github/ISSUE_TEMPLATE/) - Templates para crear issues consistentes
- [Scripts útiles](scripts/) - Scripts para automatizar tareas (ver [instrucciones de uso](#-cómo-contribuir))

### Ciclo de Desarrollo Rápido

Seguimos un ciclo Ship-Ask-Show para cada tarea:

1. **🚢 Ship**: Completa e implementa la tarea
2. **❓ Ask**: Realiza autorevisión crítica
3. **👀 Show**: Documenta y demuestra la implementación

### Gestión de Ramas

Utilizamos un Git Flow simplificado:
- `main`: Rama principal, siempre deployable
- `feature/nombre`: Para nuevas funcionalidades
- `fix/descripcion`: Para corrección de bugs

## 💫 Features que te van a VOLAR LA CABEZA 💫

### 👮‍♂️ Para Guardias (El Squad Operativo):

- **🗺️ Modo Explorador**: ¡Sigue tu ruta como si fueras un GPS humano!
- **📱 Scan & Go**: Escanea QRs y haz check-in en segundos. ¡Adiós complicaciones!
- **🚨 Alertas On Point**: Reporta incidentes en 1, 2, 3... ¡y listo!
- **📝 Activity Feed**: Comparte qué está pasando durante tu turno #RealTime
- **🧭 Rutas Custom**: Visualiza todos tus rondines como un pro

### 👑 Para Supervisores/Admins (Los Jefes del Juego):

- **👥 Squad Management**: Crea y administra tu dream team de guardias

## 🧰 Cómo contribuir

Este proyecto usa varios scripts para automatizar el flujo de trabajo. Todos están en la carpeta `scripts/`.

### 🚀 Iniciar una tarea

Para iniciar una nueva tarea (crea issue, rama y configura Kanban):

```bash
# Uso interactivo
./scripts/start_task.sh

# Uso directo
./scripts/start_task.sh feature "Implementar autenticación con Google"
```

Tipos disponibles: `feature`, `fix` o `task`

### 📋 Gestionar issues

Para crear un issue manualmente:

```bash
# Uso básico (interactivo)
./scripts/create_issue.sh

# Uso avanzado
./scripts/create_issue.sh --type feature --title "Nueva funcionalidad" --desc "Descripción detallada"
```

Para cambiar el estado de un issue en el tablero Kanban:

```bash
# Formato: ./scripts/kanban.sh <número-issue> <estado>
./scripts/kanban.sh 42 in-progress

# Estados disponibles: todo, in-progress, done
```

### 🔍 Revisar código

Para realizar una auto-revisión de tu código (ciclo Ship-Ask-Show):

```bash
# Revisa la rama actual
./scripts/review.sh

# Revisar una rama específica
./scripts/review.sh feature/42-nueva-funcionalidad
```

### 🌿 Flujo Git recomendado

```bash
# Crear una nueva rama de característica (mejor usar start_task.sh)
git checkout -b feature/nombre-descriptivo

# Hacer cambios y commits
git add .
git commit -m "[FEAT] Implementa nueva funcionalidad"

# Subir cambios y crear PR
git push -u origin feature/nombre-descriptivo
# Luego crear un Pull Request usando la plantilla
```
- **📍 Checkpoint Creator**: Dropea pins y QRs donde más se necesiten #Estrategia
- **🛣️ Ruta Master**: Diseña recorridos epic para tu equipo
- **👁️ Modo Big Brother**: Monitoreo 24/7 de todo lo que sucede #TodoBajoControl
- **📊 Dashboard de Reportes**: Toda la info que necesitas, al instante y filtrada
- **👥 Crew Control**: Cada supervisor maneja su propio squad #TeamWork

## 🔄 Ciclo de desarrollo completo

Este es el flujo de trabajo completo usando nuestros scripts:

1. **📋 Iniciar tarea**
   ```bash
   ./scripts/start_task.sh feature "Nueva funcionalidad"
   ```
   Esto crea un issue en GitHub, lo asigna al tablero Kanban y crea una rama Git.

2. **💻 Desarrollo (Ship)**
   Implementa la funcionalidad en la rama creada, haciendo commits regulares:
   ```bash
   git commit -m "[FEAT] Implementa característica X

   - Añade componente A
   - Conecta con servicio B

   Ref: #42"
   ```

3. **🔍 Auto-revisión (Ask)**
   ```bash
   ./scripts/review.sh
   ```
   Este script te guiará a través de preguntas para evaluar tu código y te ayudará a crear documentación de demostración.

4. **📤 Subir y mostrar (Show)**
   ```bash
   git push -u origin feature/42-nueva-funcionalidad
   ```
   Esto creará automáticamente un Pull Request si configuraste GitHub Actions, o puedes crearlo manualmente.

5. **✅ Completar tarea**
   ```bash
   ./scripts/kanban.sh 42 done
   ```
   Marca la tarea como completada en el tablero Kanban.

## 👥 La Comunidad de la App 👥

- **👮‍♂️ Guardia**: El MVP en terreno. Patrulla, escanea QRs y reporta todo lo que pasa. #HéroeSilencioso
- **🕵️‍♀️ Supervisor/Admin**: El estratega y cerebro de la operación. Crea rutas, gestiona equipos y analiza datos. #LíderDigital

## 🔄 Así Funciona (Spoiler: ¡Es súper fácil!) 🔄

1. 🗺️ El supervisor dropea checkpoints en el mapa (como Pokémon GO pero en versión seguridad 😎)
2. 🛣️ Arma rutas épicas conectando estos puntos #StrategicMind
3. 📱 El guardia recibe notificaciones de sus asignaciones en la app
4. 🔍 Durante el rondín, escanea QRs como si coleccionara insignias #Achievement
5. 📸 Si ve algo sospechoso, ¡snap! Lo reporta en segundos
6. 📊 El supervisor recibe todo en su dashboard en tiempo real #DataDriven

## 🛠️ Stack Tecnológico de Otro Nivel 🛠️

- **💙 Flutter**: Porque las apps nativas ya son SO last season #CrossPlatform
- **🔥 Firebase**: Backend as a Service que te hace la vida más fácil #NoSQL #Serverless
- **🗺️ Google Maps API**: Para que nadie se pierda nunca (excepto cuando quieres perderte 😏)
- **📷 QR Code Scanner**: Escanea como un pro y nunca más digas "no estuve ahí" #Evidencia

## 📋 Lo que Necesitas para Sumarte al Proyecto 📋

- 📱 Flutter SDK (la magia comienza aquí)
- 💻 Android Studio / Xcode (pick your fighter)
- 📲 Un dispositivo que no sea de la era jurásica (o un emulador cool)

## 🚀 ¿Cómo Empezar? ¡Es Pan Comido! 🚀

```bash
# Clona este repo (porque compartir es vivir)
git clone https://github.com/your-username/security_guard_mx.git

# Entra a la carpeta (como entrar a una nueva dimensión)
cd security_guard_mx

# Instala todo lo cool (dependencias y así)
flutter pub get

# ¡Y BOOM! 💥 Lanza la app
flutter run
```

## 🔮 ¿En qué Fase Estamos? 🔮

⚙️ En modo desarrollo activo y con toda la vibra ⚙️
¡Pronto más updates! No olvides darle ⭐ al repo si te gustó.

---

### 📱 Seguridad Inteligente para la Generación Digital 📱
#### #TechForSecurity #NextLevelSecurity #InnovaciónMX
