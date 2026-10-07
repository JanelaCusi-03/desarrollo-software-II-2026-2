# Práctica 03 - Introducción a Flutter en Android Studio

Desarrollo de Software II - UNSAAC. Una sola app que une los 3 ejercicios de la guía
más el ejercicio propuesto (calculadora), navegables desde una barra inferior.

## Estructura

```
lib/
├── main.dart                         # Punto de entrada (MaterialApp)
├── logic/
│   └── calculadora_logica.dart       # Lógica pura de la calculadora
└── screens/
    ├── home_screen.dart              # UNE todo: NavigationBar + IndexedStack
    ├── ejercicio1_hola.dart          # Ej. 1: Scaffold, Text, Container, Row, Column, Image
    ├── ejercicio2_perfil.dart        # Ej. 2: Card, CircleAvatar, Row, Column
    ├── ejercicio3_contador.dart      # Ej. 3: StatefulWidget + setState
    └── ejercicio4_calculadora.dart   # Propuesto: calculadora (GridView)
test/widget_test.dart                 # Pruebas de la lógica
informe/informe.tex                   # Informe en LaTeX
```

## Cómo usarlo

1. Crear el proyecto en Android Studio: `File > New > New Flutter Project`, nombre `mi_primera_app`.
2. Copiar `lib/`, `test/`, `assets/`, `informe/` y este `README.md` dentro del proyecto (reemplazando `lib/main.dart` y `test/widget_test.dart`).
3. (Opcional) Poner una imagen en `assets/images/logo.png` y declarar en `pubspec.yaml`:
   ```yaml
   flutter:
     uses-material-design: true
     assets:
       - assets/images/
   ```
   Si no se hace, el Ejercicio 1 muestra el `FlutterLogo` como respaldo.
4. `flutter pub get` y `flutter run`. Pruebas: `flutter test`.

## Git

```bash
git add .
git commit -m "Práctica 03: Flutter - ejercicios 1, 2, 3 y calculadora"
git push
```
