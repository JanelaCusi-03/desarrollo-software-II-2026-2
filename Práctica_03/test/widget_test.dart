// test/widget_test.dart
// Pruebas unitarias de la lógica de la calculadora.
// Ejecutar con:  flutter test
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_primera_app/logic/calculadora_logica.dart';

void ingresar(CalculadoraLogica c, String teclas) {
  for (final t in teclas.split('')) {
    if ('0123456789'.contains(t)) {
      c.digito(t);
    } else if (t == '.') {
      c.punto();
    } else if (t == '=') {
      c.igual();
    } else {
      c.operacion(t);
    }
  }
}

void main() {
  test('suma simple', () {
    final c = CalculadoraLogica();
    ingresar(c, '2+3=');
    expect(c.entrada, '5');
  });

  test('decimales sin error de punto flotante', () {
    final c = CalculadoraLogica();
    ingresar(c, '0.1+0.2=');
    expect(c.entrada, '0.3');
  });

  test('resultado negativo', () {
    final c = CalculadoraLogica();
    ingresar(c, '3-5=');
    expect(c.entrada, '-2');
    expect(c.valor < 0, true);
  });

  test('operaciones encadenadas de izquierda a derecha', () {
    final c = CalculadoraLogica();
    ingresar(c, '2+3×4=');
    expect(c.entrada, '20');
  });

  test('división entre cero', () {
    final c = CalculadoraLogica();
    ingresar(c, '8÷0=');
    expect(c.hayError, true);
    expect(c.entrada, 'Error');
  });

  test('C limpia el display', () {
    final c = CalculadoraLogica();
    ingresar(c, '99+1');
    c.limpiar();
    expect(c.entrada, '0');
    expect(c.valor, 0);
  });
}
