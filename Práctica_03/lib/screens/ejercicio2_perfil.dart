// lib/screens/ejercicio2_perfil.dart
// Ejercicio 2: tarjeta de perfil con Card, CircleAvatar, Row y Column.
import 'package:flutter/material.dart';

class Ejercicio2Screen extends StatelessWidget {
  const Ejercicio2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarjeta de Perfil'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar circular
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue.shade200,
                    child: const Icon(Icons.person, size: 70, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  // Nombre y carrera
                  const Text(
                    'Ada Lovelace',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ingeniería Informática',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                  const Divider(height: 32),
                  // Fila de estadísticas
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Estadistica(valor: '120', etiqueta: 'Proyectos'),
                      _Estadistica(valor: '4.8', etiqueta: 'Rating'),
                      _Estadistica(valor: '5+', etiqueta: 'Años'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Botón de acción
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Mensaje enviado')),
                      );
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('Enviar Mensaje'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar reutilizable para cada estadística
class _Estadistica extends StatelessWidget {
  final String valor;
  final String etiqueta;

  const _Estadistica({required this.valor, required this.etiqueta});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          valor,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(etiqueta, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
