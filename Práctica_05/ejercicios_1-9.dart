// ============================================================
// PRÁCTICA 05 - Manejo de Eventos e Interactividad en Flutter
// Desarrollo de Software II - UNSAAC
//
// Una sola app con los 9 ejercicios propuestos (básico,
// intermedio y avanzado) accesibles desde un menú principal.
//
// Uso: reemplaza el contenido de lib/main.dart con este archivo
// y ejecuta:  flutter run
// ============================================================

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MiApp());

// ------------------------------------------------------------
// APP PRINCIPAL
// ------------------------------------------------------------
class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Práctica 05 - Eventos en Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const MenuPage(),
    );
  }
}

// ------------------------------------------------------------
// MENÚ PRINCIPAL
// ------------------------------------------------------------
class Ejercicio {
  final String titulo;
  final String descripcion;
  final IconData icono;
  final Widget pagina;
  const Ejercicio(this.titulo, this.descripcion, this.icono, this.pagina);
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Ejercicio>> niveles = {
      'Nivel Básico': [
        const Ejercicio('1. Cambiar color de fondo',
            'Botón que cambia el color de fondo', Icons.palette, ColorFondoPage()),
        const Ejercicio('2. Contador + y -',
            'Aumentar, disminuir y reiniciar', Icons.exposure, ContadorPage()),
        const Ejercicio('3. Capturar texto',
            'Mostrar en pantalla lo que se escribe', Icons.text_fields, TextoPage()),
      ],
      'Nivel Intermedio': [
        const Ejercicio('4. Formulario nombre y edad',
            'Captura de varios datos', Icons.badge, FormularioPage()),
        const Ejercicio('5. Switch on/off',
            'Encendido y apagado', Icons.toggle_on, SwitchPage()),
        const Ejercicio('6. Doble clic',
            'Detectar tap, doble tap y pulsación larga', Icons.touch_app, DobleClicPage()),
      ],
      'Nivel Avanzado': [
        const Ejercicio('7. Lista dinámica',
            'Agregar y eliminar elementos', Icons.list_alt, ListaDinamicaPage()),
        const Ejercicio('8. Validación de formulario',
            'Form + validators', Icons.verified_user, ValidacionPage()),
        const Ejercicio('9. Juego: contador de taps',
            'Cuántos taps haces en 10 segundos', Icons.sports_esports, JuegoTapsPage()),
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica 05 - Eventos'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          for (final nivel in niveles.entries) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Text(
                nivel.key,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            for (final e in nivel.value)
              Card(
                child: ListTile(
                  leading: Icon(e.icono),
                  title: Text(e.titulo),
                  subtitle: Text(e.descripcion),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => e.pagina),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// NIVEL BÁSICO
// ============================================================

// ------------------------------------------------------------
// 1. Botón que cambia el color de fondo
// ------------------------------------------------------------
class ColorFondoPage extends StatefulWidget {
  const ColorFondoPage({super.key});

  @override
  State<ColorFondoPage> createState() => _ColorFondoPageState();
}

class _ColorFondoPageState extends State<ColorFondoPage> {
  final Random _random = Random();
  Color _fondo = Colors.white;

  void _cambiarColor() {
    setState(() {
      _fondo = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fondo,
      appBar: AppBar(title: const Text('1. Color de fondo')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _cambiarColor,
          icon: const Icon(Icons.color_lens),
          label: const Text('Cambiar color'),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// 2. Contador con botones + y -
// ------------------------------------------------------------
class ContadorPage extends StatefulWidget {
  const ContadorPage({super.key});

  @override
  State<ContadorPage> createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {
  int _contador = 0;

  void _incrementar() => setState(() => _contador++);
  void _decrementar() => setState(() => _contador--);
  void _reiniciar() => setState(() => _contador = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Contador')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Valor: $_contador', style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'menos',
                  onPressed: _decrementar,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: 'mas',
                  onPressed: _incrementar,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(onPressed: _reiniciar, child: const Text('Reiniciar')),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// 3. Capturar texto y mostrarlo en pantalla
// ------------------------------------------------------------
class TextoPage extends StatefulWidget {
  const TextoPage({super.key});

  @override
  State<TextoPage> createState() => _TextoPageState();
}

class _TextoPageState extends State<TextoPage> {
  final TextEditingController _controlador = TextEditingController();
  String _texto = '';

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. Capturar texto')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controlador,
              decoration: const InputDecoration(
                labelText: 'Escribe algo',
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) => setState(() => _texto = valor),
            ),
            const SizedBox(height: 24),
            Text(
              _texto.isEmpty ? 'Aquí aparecerá tu texto...' : _texto,
              style: const TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                _controlador.clear();
                setState(() => _texto = '');
              },
              icon: const Icon(Icons.clear),
              label: const Text('Limpiar'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// NIVEL INTERMEDIO
// ============================================================

// ------------------------------------------------------------
// 4. Formulario con nombre y edad
// ------------------------------------------------------------
class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _edadCtrl = TextEditingController();
  String _mensaje = '';

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _edadCtrl.dispose();
    super.dispose();
  }

  void _mostrarSaludo() {
    final nombre = _nombreCtrl.text.trim();
    final edad = _edadCtrl.text.trim();
    setState(() {
      if (nombre.isEmpty || edad.isEmpty) {
        _mensaje = 'Completa ambos campos';
      } else {
        _mensaje = 'Hola, $nombre. Tienes $edad años.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4. Nombre y edad')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() => _mensaje = ''),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _edadCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Edad',
                prefixIcon: Icon(Icons.cake),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() => _mensaje = ''),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _mostrarSaludo,
              child: const Text('Enviar'),
            ),
            const SizedBox(height: 24),
            Text(_mensaje, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// 5. Switch (encendido / apagado)
// ------------------------------------------------------------
class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool _encendido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('5. Switch')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _encendido ? Colors.amber : Colors.grey.shade400,
                boxShadow: _encendido
                    ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.7),
                    blurRadius: 30,
                    spreadRadius: 8,
                  ),
                ]
                    : [],
              ),
              child: Icon(
                _encendido ? Icons.lightbulb : Icons.lightbulb_outline,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _encendido ? 'ENCENDIDO' : 'APAGADO',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Switch(
              value: _encendido,
              onChanged: (valor) => setState(() => _encendido = valor),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// 6. Detectar doble clic en un contenedor (+ tap y long press)
// ------------------------------------------------------------
class DobleClicPage extends StatefulWidget {
  const DobleClicPage({super.key});

  @override
  State<DobleClicPage> createState() => _DobleClicPageState();
}

class _DobleClicPageState extends State<DobleClicPage> {
  String _evento = 'Toca el cuadro';
  Color _color = Colors.blue;
  int _dobles = 0;

  void _registrar(String evento, Color color) {
    setState(() {
      _evento = evento;
      _color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6. Doble clic')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => _registrar('Tap detectado', Colors.blue),
              onDoubleTap: () {
                _dobles++;
                _registrar('¡Doble tap!', Colors.green);
              },
              onLongPress: () => _registrar('Presión larga', Colors.red),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  _evento,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Dobles taps: $_dobles', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            const Text('Prueba: tap, doble tap y mantener presionado'),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// NIVEL AVANZADO
// ============================================================

// ------------------------------------------------------------
// 7. Lista dinámica (agregar y eliminar elementos)
// ------------------------------------------------------------
class ListaDinamicaPage extends StatefulWidget {
  const ListaDinamicaPage({super.key});

  @override
  State<ListaDinamicaPage> createState() => _ListaDinamicaPageState();
}

class _ListaDinamicaPageState extends State<ListaDinamicaPage> {
  final TextEditingController _controlador = TextEditingController();
  final List<String> _elementos = [];

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  void _agregar() {
    final texto = _controlador.text.trim();
    if (texto.isEmpty) return;
    setState(() => _elementos.add(texto));
    _controlador.clear();
  }

  void _eliminar(int indice) {
    setState(() => _elementos.removeAt(indice));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('7. Lista dinámica')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controlador,
                    decoration: const InputDecoration(
                      labelText: 'Nuevo elemento',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _agregar(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(onPressed: _agregar, child: const Text('Agregar')),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _elementos.isEmpty
                  ? const Center(child: Text('La lista está vacía'))
                  : ListView.builder(
                itemCount: _elementos.length,
                itemBuilder: (context, i) {
                  return Dismissible(
                    key: ValueKey('${_elementos[i]}-$i'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => _eliminar(i),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text('${i + 1}')),
                        title: Text(_elementos[i]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _eliminar(i),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// 8. Validación de formulario
// ------------------------------------------------------------
class ValidacionPage extends StatefulWidget {
  const ValidacionPage({super.key});

  @override
  State<ValidacionPage> createState() => _ValidacionPageState();
}

class _ValidacionPageState extends State<ValidacionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _correoCtrl = TextEditingController();
  final TextEditingController _edadCtrl = TextEditingController();
  final TextEditingController _claveCtrl = TextEditingController();
  bool _ocultarClave = true;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _correoCtrl.dispose();
    _edadCtrl.dispose();
    _claveCtrl.dispose();
    super.dispose();
  }

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Registro exitoso! Bienvenido, ${_nombreCtrl.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('8. Validación')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'El nombre es obligatorio';
                  if (v.trim().length < 3) return 'Mínimo 3 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _correoCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'El correo es obligatorio';
                  final regex = RegExp(r'^[\w.\-]+@[\w\-]+(\.[\w\-]+)+$');
                  if (!regex.hasMatch(v.trim())) return 'Correo no válido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _edadCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'La edad es obligatoria';
                  final edad = int.tryParse(v.trim());
                  if (edad == null) return 'Ingresa solo números';
                  if (edad < 1 || edad > 120) return 'Edad entre 1 y 120';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _claveCtrl,
                obscureText: _ocultarClave,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _ocultarClave ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => _ocultarClave = !_ocultarClave),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'La contraseña es obligatoria';
                  if (v.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _enviar,
                  child: const Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// 9. Juego simple: contador de taps (10 segundos)
// ------------------------------------------------------------
class JuegoTapsPage extends StatefulWidget {
  const JuegoTapsPage({super.key});

  @override
  State<JuegoTapsPage> createState() => _JuegoTapsPageState();
}

class _JuegoTapsPageState extends State<JuegoTapsPage> {
  static const int _duracion = 10;

  int _taps = 0;
  int _record = 0;
  int _tiempo = _duracion;
  bool _jugando = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _iniciar() {
    _timer?.cancel();
    setState(() {
      _taps = 0;
      _tiempo = _duracion;
      _jugando = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_tiempo <= 1) {
        t.cancel();
        setState(() {
          _tiempo = 0;
          _jugando = false;
          if (_taps > _record) _record = _taps;
        });
      } else {
        setState(() => _tiempo--);
      }
    });
  }

  void _tap() {
    if (_jugando) setState(() => _taps++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('9. Juego de taps')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tiempo: $_tiempo s', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text('Taps: $_taps',
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            Text('Récord: $_record', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _tap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _jugando ? Colors.deepOrange : Colors.grey,
                ),
                alignment: Alignment.center,
                child: Text(
                  _jugando ? '¡TAP!' : 'Inactivo',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (!_jugando)
              FilledButton.icon(
                onPressed: _iniciar,
                icon: const Icon(Icons.play_arrow),
                label: Text(_taps == 0 && _tiempo == _duracion
                    ? 'Comenzar'
                    : 'Jugar de nuevo'),
              ),
            if (!_jugando && _taps > 0 && _tiempo == 0)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('¡Tiempo! Hiciste $_taps taps',
                    style: const TextStyle(fontSize: 18)),
              ),
          ],
        ),
      ),
    );
  }
}
