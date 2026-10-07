// lib/screens/home_screen.dart
// Pantalla contenedora: UNE los ejercicios en una sola app mediante una
// barra de navegación inferior. IndexedStack conserva el estado de cada
// pestaña (por ejemplo, el valor del contador) al cambiar entre ellas.
import 'package:flutter/material.dart';

import 'ejercicio1_hola.dart';
import 'ejercicio2_perfil.dart';
import 'ejercicio3_contador.dart';
import 'ejercicio4_calculadora.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indice = 0;

  // Cada ejercicio es un widget independiente (cada uno en su archivo).
  static const List<Widget> _pantallas = [
    Ejercicio1Screen(),
    Ejercicio2Screen(),
    Ejercicio3Screen(),
    Ejercicio4Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _indice, children: _pantallas),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (i) => setState(() => _indice = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Ej. 1'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Ej. 2'),
          NavigationDestination(icon: Icon(Icons.exposure_plus_1), label: 'Ej. 3'),
          NavigationDestination(icon: Icon(Icons.calculate_outlined), selectedIcon: Icon(Icons.calculate), label: 'Propuesto'),
        ],
      ),
    );
  }
}
