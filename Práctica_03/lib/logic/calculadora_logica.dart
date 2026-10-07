// lib/logic/calculadora_logica.dart
// Lógica pura de la calculadora (sin widgets), por eso es fácil de probar.
// Las operaciones encadenadas se evalúan de izquierda a derecha, como en
// una calculadora básica: 2 + 3 × 4 = 20.
class CalculadoraLogica {
  String entrada = '0'; // texto mostrado en el display
  String? expresion; // línea secundaria, ej. "12 + "
  double? _acumulado;
  String? _operador;
  bool _reiniciarEntrada = false;
  bool hayError = false;

  /// Valor numérico del display (0 si hay error).
  double get valor => hayError ? 0 : (double.tryParse(entrada) ?? 0);

  void digito(String d) {
    if (hayError) limpiar();
    if (_reiniciarEntrada) {
      entrada = d;
      _reiniciarEntrada = false;
      return;
    }
    final cifras = entrada.replaceAll('-', '').replaceAll('.', '').length;
    if (cifras >= 12) return;
    entrada = entrada == '0' ? d : entrada + d;
  }

  void punto() {
    if (hayError) limpiar();
    if (_reiniciarEntrada) {
      entrada = '0.';
      _reiniciarEntrada = false;
      return;
    }
    if (!entrada.contains('.')) entrada += '.';
  }

  void operacion(String op) {
    if (hayError) return;
    if (_acumulado != null && _operador != null && !_reiniciarEntrada) {
      // Encadenar: resolver lo pendiente antes de aplicar el nuevo operador
      final r = _calcular(_acumulado!, valor, _operador!);
      if (r == null) return _marcarError();
      _acumulado = r;
      entrada = formatear(r);
    } else if (_acumulado == null) {
      _acumulado = valor;
    }
    _operador = op;
    _reiniciarEntrada = true;
    expresion = '${formatear(_acumulado!)} $op';
  }

  void igual() {
    if (hayError || _acumulado == null || _operador == null) return;
    final a = _acumulado!;
    final b = valor;
    final r = _calcular(a, b, _operador!);
    if (r == null) return _marcarError();
    expresion = '${formatear(a)} $_operador ${formatear(b)} =';
    entrada = formatear(r);
    _acumulado = null;
    _operador = null;
    _reiniciarEntrada = true;
  }

  void limpiar() {
    entrada = '0';
    expresion = null;
    _acumulado = null;
    _operador = null;
    _reiniciarEntrada = false;
    hayError = false;
  }

  double? _calcular(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        return b == 0 ? null : a / b;
    }
    return null;
  }

  void _marcarError() {
    hayError = true;
    entrada = 'Error';
    expresion = null;
    _acumulado = null;
    _operador = null;
    _reiniciarEntrada = true;
  }

  /// Quita decimales sobrantes: 5.0 -> "5", 0.30000000000000004 -> "0.3".
  static String formatear(double v) {
    if (v == 0) return '0';
    var s = double.parse(v.toStringAsPrecision(12)).toString();
    if (s.endsWith('.0')) s = s.substring(0, s.length - 2);
    return s;
  }
}
