import 'package:flutter/material.dart';

void main() {
  runApp(const MiAplicacion());
}
 
class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Práctica 01'),
        ),
        body: const Center(
          child: Text(
            'Hola Mundo',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
