// lib/screens/ejercicio1_hola.dart
// Ejercicio 1: primera pantalla con Scaffold, Text, Container, Row, Column e Image.
import 'package:flutter/material.dart';

class Ejercicio1Screen extends StatelessWidget {
  const Ejercicio1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica Flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.shade200, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Widget Image: usa assets/images/logo.png si existe;
              // si no, muestra el FlutterLogo como respaldo.
              Image.asset(
                'assets/images/logo.png',
                height: 100,
                errorBuilder: (context, error, stack) =>
                    const FlutterLogo(size: 100),
              ),
              const SizedBox(height: 16),
              const Text(
                '¡Hola, Flutter!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Mi primera aplicación',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 20),
              // Widget Row con íconos y textos
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_android, color: Colors.blue),
                  SizedBox(width: 6),
                  Text('Android'),
                  SizedBox(width: 20),
                  Icon(Icons.code, color: Colors.blue),
                  SizedBox(width: 6),
                  Text('Dart'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
