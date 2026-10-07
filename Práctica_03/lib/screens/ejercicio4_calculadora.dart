// lib/screens/ejercicio4_calculadora.dart
// Ejercicio propuesto: calculadora básica con StatefulWidget y GridView.
// Color del display: positivo = azul, negativo = rojo, cero = gris.
import 'package:flutter/material.dart';

import '../logic/calculadora_logica.dart';

class Ejercicio4Screen extends StatefulWidget {
  const Ejercicio4Screen({super.key});

  @override
  State<Ejercicio4Screen> createState() => _Ejercicio4ScreenState();
}

class _Ejercicio4ScreenState extends State<Ejercicio4Screen> {
  final CalculadoraLogica _logica = CalculadoraLogica();

  static const List<String> _botones = [
    '7', '8', '9', '÷',
    '4', '5', '6', '×',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
  ];

  static const String _operadores = '÷×-+';

  void _pulsar(String t) {
    setState(() {
      if (t == 'C') {
        _logica.limpiar();
      } else if (t == '=') {
        _logica.igual();
      } else if (t == '.') {
        _logica.punto();
      } else if (_operadores.contains(t)) {
        _logica.operacion(t);
      } else {
        _logica.digito(t);
      }
    });
  }

  Color get _colorDisplay {
    if (_logica.hayError) return Colors.red;
    final v = _logica.valor;
    if (v > 0) return Colors.blue;
    if (v < 0) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // ---------- Display ----------
              Expanded(flex: 2, child: _construirDisplay()),
              const SizedBox(height: 12),
              // ---------- Botón C ----------
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => _pulsar('C'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('C', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(height: 8),
              // ---------- Teclado (GridView) ----------
              Expanded(flex: 5, child: _construirTeclado()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirDisplay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _logica.expresion ?? '',
            style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          // FittedBox reduce el texto si el número es muy largo
          FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: _colorDisplay,
              ),
              child: Text(_logica.entrada),
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirTeclado() {
    return LayoutBuilder(
      builder: (context, c) {
        const columnas = 4;
        const filas = 4;
        const espacio = 8.0;
        final ancho = (c.maxWidth - espacio * (columnas - 1)) / columnas;
        final alto = (c.maxHeight - espacio * (filas - 1)) / filas;
        return GridView.count(
          crossAxisCount: columnas,
          mainAxisSpacing: espacio,
          crossAxisSpacing: espacio,
          childAspectRatio: ancho / alto,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: _botones.map(_construirBoton).toList(),
        );
      },
    );
  }

  Widget _construirBoton(String t) {
    final esOperador = _operadores.contains(t);
    final esIgual = t == '=';
    return ElevatedButton(
      onPressed: () => _pulsar(t),
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: esIgual
            ? Colors.blue.shade700
            : esOperador
                ? Colors.blue.shade100
                : Colors.white,
        foregroundColor: esIgual ? Colors.white : Colors.blue.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(t, style: const TextStyle(fontSize: 28)),
    );
  }
}
