# 📝 Guía de Codificación

Esta guía establece las convenciones de código para el proyecto Security Guard MX.

## 📋 Estilo de Código Dart/Flutter

### 🔤 Nomenclatura

- **Clases**: PascalCase
  ```dart
  class UserProfile { }
  ```

- **Variables y funciones**: camelCase
  ```dart
  String userName;
  void updateProfile() { }
  ```

- **Constantes**: k + PascalCase
  ```dart
  const kDefaultPadding = 16.0;
  ```

- **Enums**: PascalCase para nombre, camelCase para valores
  ```dart
  enum UserRole { admin, supervisor, guard }
  ```

- **Archivos**: snake_case
  ```
  user_profile.dart
  ```

### 🏗️ Estructura de Archivos

```
lib/
  ├── main.dart
  ├── app/
  │   ├── app.dart
  │   └── routes.dart
  ├── core/
  │   ├── constants/
  │   ├── errors/
  │   └── utils/
  ├── data/
  │   ├── models/
  │   ├── repositories/
  │   └── services/
  ├── domain/
  │   ├── entities/
  │   └── usecases/
  └── presentation/
      ├── screens/
      ├── widgets/
      └── controllers/
```

### 🧩 Patrones de Diseño

- **Repository Pattern** para acceso a datos
- **Provider/BLoC** para gestión de estado
- **Clean Architecture** para separación de responsabilidades

## 💻 Prácticas de Código

### ✅ DOs

- **DO** escribir comentarios para código complejo
- **DO** seguir el principio DRY (Don't Repeat Yourself)
- **DO** escribir tests unitarios para lógica de negocio
- **DO** gestionar errores adecuadamente
- **DO** usar widgets const cuando sea posible

### ❌ DON'Ts

- **DON'T** dejar código comentado sin explicación
- **DON'T** crear archivos con múltiples responsabilidades
- **DON'T** usar strings codificados (hardcoded)
- **DON'T** ignorar warnings del linter

## 🧪 Testing

### Tipos de Tests

- **Unit Tests**: Para lógica de negocio y funciones puras
- **Widget Tests**: Para componentes UI complejos
- **Integration Tests**: Para flujos completos

### Convenciones

- **Archivos**: `{nombre_archivo}_test.dart`
- **Descripción**: Usar oraciones completas y descriptivas

```dart
test('Should return user profile when fetch is successful', () {
  // ...
});
```

## 📚 Documentación

- Usar documentación de estilo Dart Doc para clases y métodos públicos
- Incluir ejemplos de uso cuando sea apropiado

```dart
/// Widget que muestra el perfil del usuario.
///
/// Ejemplo:
/// ```dart
/// UserProfileWidget(
///   userId: '123',
///   showAvatar: true,
/// )
/// ```
class UserProfileWidget extends StatelessWidget {
  // ...
}
```

## ⚡ Rendimiento

- Usar `const` constructors cuando sea posible
- Evitar rebuilds innecesarios
- Implementar pagination para listas grandes
- Optimizar assets e imágenes
