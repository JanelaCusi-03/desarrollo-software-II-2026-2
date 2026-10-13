import 'package:flutter/material.dart';

// ============================================================
// PRÁCTICA 04 - Guía Práctica de Widgets en Flutter
// Desarrollo de Software II - UNSAAC
// Todos los widgets de la guía en UNA sola app.
// Reemplaza el contenido de lib/main.dart con este archivo.
// ============================================================

void main() {
  runApp(const MiApp());
}

// ---------------- Widget raíz (StatelessWidget) ----------------
class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Primera App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MiPantallaPrincipal(),
      // Rutas nombradas (Navigator.pushNamed)
      routes: {
        '/detalle': (_) => const DetalleScreen(),
      },
    );
  }
}

// ---------------- Pantalla principal con BottomNavigationBar ----------------
class MiPantallaPrincipal extends StatefulWidget {
  const MiPantallaPrincipal({super.key});

  @override
  State<MiPantallaPrincipal> createState() => _MiPantallaPrincipalState();
}

class _MiPantallaPrincipalState extends State<MiPantallaPrincipal> {
  int _index = 0;

  final List<String> _titulos = const [
    'Layout',
    'Display',
    'Input',
    'Navegación',
    'Feedback',
  ];

  final List<Widget> _paginas = const [
    LayoutPage(),
    DisplayPage(),
    InputPage(),
    NavegacionPage(),
    FeedbackPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar: title, leading, actions, backgroundColor
      appBar: AppBar(
        title: Text('¡Hola, Flutter! · ${_titulos[_index]}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: IndexedStack(index: _index, children: _paginas),
      // BottomNavigationBar con type fixed (más de 3 ítems)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Layout'),
          BottomNavigationBarItem(
              icon: Icon(Icons.image), label: 'Display'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), label: 'Input'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore), label: 'Navegación'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Feedback'),
        ],
      ),
    );
  }
}

// ---------------- Widget auxiliar para cada sección ----------------
class Seccion extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final Widget child;

  const Seccion({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: cs.primary),
            ),
            const SizedBox(height: 4),
            Text(descripcion,
                style: Theme.of(context).textTheme.bodySmall),
            const Divider(height: 24),
            child,
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 1. LAYOUT
// ============================================================
class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Container
        Seccion(
          titulo: 'Container',
          descripcion:
          'Caja con padding, margen, decoración y restricciones de tamaño.',
          child: Container(
            width: 200,
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Hola', style: TextStyle(color: Colors.white)),
          ),
        ),

        // Row
        Seccion(
          titulo: 'Row',
          descripcion: 'Alinea sus hijos de forma horizontal.',
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.star),
              Text('Texto'),
              Icon(Icons.favorite),
            ],
          ),
        ),

        // Column
        Seccion(
          titulo: 'Column',
          descripcion: 'Alinea sus hijos de forma vertical.',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Título',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Subtítulo'),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: () {}, child: const Text('Botón')),
            ],
          ),
        ),

        // Stack
        Seccion(
          titulo: 'Stack',
          descripcion: 'Apila widgets superpuestos en el eje Z.',
          child: SizedBox(
            height: 150,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://picsum.photos/400/200',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade300,
                      child: const Center(child: Icon(Icons.image, size: 48)),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 8,
                  right: 8,
                  child: Text(
                    'Overlay',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Expanded & Flexible
        Seccion(
          titulo: 'Expanded & Flexible',
          descripcion: 'flex:2 + flex:1 → el primero toma 2/3 del espacio.',
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(color: Colors.blue),
                ),
                Expanded(
                  flex: 1,
                  child: Container(color: Colors.red),
                ),
              ],
            ),
          ),
        ),

        // Padding & SizedBox
        Seccion(
          titulo: 'Padding & SizedBox',
          descripcion: 'Padding agrega espacio interno; SizedBox da tamaño fijo.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.amber.shade100,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text('Con espacio'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Text('A'),
                  SizedBox(width: 8),
                  Text('B'),
                  SizedBox(width: 8),
                  Text('C'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// 2. DISPLAY
// ============================================================
class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(8, (i) => 'Elemento ${i + 1}');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Text
        Seccion(
          titulo: 'Text',
          descripcion: 'Texto con estilos tipográficos completos.',
          child: const Text(
            'Hola Flutter, este es un texto largo que se cortará con puntos suspensivos si no cabe en dos líneas de la pantalla.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Image
        Seccion(
          titulo: 'Image',
          descripcion: 'Image.network con BoxFit.cover (necesita internet).',
          child: Image.network(
            'https://picsum.photos/400/200',
            fit: BoxFit.cover,
            width: 200,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),

        // Card
        Seccion(
          titulo: 'Card',
          descripcion: 'Superficie elevada con sombra y esquinas redondeadas.',
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Contenido'),
            ),
          ),
        ),

        // CircleAvatar
        Seccion(
          titulo: 'CircleAvatar',
          descripcion: 'Avatar circular con iniciales o imagen.',
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.purple,
                child: Text('AB', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,
                backgroundImage:
                const NetworkImage('https://picsum.photos/100'),
              ),
            ],
          ),
        ),

        // ListView
        Seccion(
          titulo: 'ListView.builder',
          descripcion: 'Lista desplazable y eficiente (lazy).',
          child: SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(items[index]),
                );
              },
            ),
          ),
        ),

        // GridView
        Seccion(
          titulo: 'GridView.builder',
          descripcion: 'Cuadrícula con 2 columnas.',
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => Card(
              color: Colors.primaries[index % Colors.primaries.length]
                  .shade100,
              child: Center(child: Text('Item ${index + 1}')),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// 3. INPUT
// ============================================================
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isOn = false;
  bool _checked = false;
  String _selected = 'Opción A';
  double _value = 50;
  int _clicks = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ElevatedButton
        Seccion(
          titulo: 'ElevatedButton',
          descripcion: 'Botón principal. Con onPressed null queda deshabilitado.',
          child: Wrap(
            spacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => _clicks++),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Aceptar ($_clicks)'),
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text('Presióname'),
              ),
            ],
          ),
        ),

        // TextField
        Seccion(
          titulo: 'TextField',
          descripcion: 'Campo de texto con decoración y controller.',
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  hintText: 'usuario@email.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => setState(() {}),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Text('Escribiste: ${_controller.text}')),
                  TextButton(
                    onPressed: () => setState(() => _controller.clear()),
                    child: const Text('Limpiar'),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Switch & Checkbox
        Seccion(
          titulo: 'Switch & Checkbox',
          descripcion: 'Controles booleanos.',
          child: Column(
            children: [
              Row(
                children: [
                  Switch(
                    value: _isOn,
                    onChanged: (val) => setState(() => _isOn = val),
                  ),
                  Text(_isOn ? 'Encendido' : 'Apagado'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checked,
                    onChanged: (val) => setState(() => _checked = val!),
                  ),
                  Text(_checked ? 'Marcado' : 'Sin marcar'),
                ],
              ),
            ],
          ),
        ),

        // DropdownButton
        Seccion(
          titulo: 'DropdownButton',
          descripcion: 'Selector desplegable (isExpanded: true).',
          child: DropdownButton<String>(
            value: _selected,
            isExpanded: true,
            items: ['Opción A', 'Opción B', 'Opción C']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _selected = val!),
          ),
        ),

        // Slider
        Seccion(
          titulo: 'Slider',
          descripcion: 'Valor dentro de un rango, con divisiones.',
          child: Slider(
            value: _value,
            min: 0.0,
            max: 100.0,
            divisions: 10,
            label: _value.round().toString(),
            onChanged: (val) => setState(() => _value = val),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// 4. NAVEGACIÓN
// ============================================================
class NavegacionPage extends StatelessWidget {
  const NavegacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // AppBar (demo)
        Seccion(
          titulo: 'AppBar',
          descripcion:
          'La barra superior de esta app es un AppBar. Aquí una de muestra.',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: kToolbarHeight,
              child: AppBar(
                primary: false,
                automaticallyImplyLeading: false,
                title: const Text('Mi App'),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                leading: IconButton(
                    icon: const Icon(Icons.menu), onPressed: () {}),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.search), onPressed: () {}),
                ],
              ),
            ),
          ),
        ),

        // BottomNavigationBar (explicación)
        const Seccion(
          titulo: 'BottomNavigationBar',
          descripcion:
          'Es la barra inferior que estás usando ahora mismo para cambiar entre Layout, Display, Input, Navegación y Feedback.',
          child: Row(
            children: [
              Icon(Icons.arrow_downward),
              SizedBox(width: 8),
              Expanded(
                child: Text('Mira abajo: type fixed porque hay 5 ítems.'),
              ),
            ],
          ),
        ),

        // TabBar
        Seccion(
          titulo: 'TabBar + TabBarView',
          descripcion: 'Pestañas sincronizadas con DefaultTabController.',
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'A'),
                    Tab(text: 'B'),
                    Tab(text: 'C'),
                  ],
                ),
                SizedBox(
                  height: 80,
                  child: TabBarView(
                    children: [
                      Container(
                          color: Colors.blue.shade50,
                          child: const Center(child: Text('Panel A'))),
                      Container(
                          color: Colors.green.shade50,
                          child: const Center(child: Text('Panel B'))),
                      Container(
                          color: Colors.orange.shade50,
                          child: const Center(child: Text('Panel C'))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Navigator & Routes
        Seccion(
          titulo: 'Navigator & Routes',
          descripcion: 'push, pop, pushNamed y pushReplacement.',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DetalleScreen()),
                  );
                },
                child: const Text('push'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/detalle'),
                child: const Text('pushNamed'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Pantalla de detalle (destino de la navegación)
class DetalleScreen extends StatelessWidget {
  const DetalleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Segunda pantalla', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver atrás (pop)'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 5. FEEDBACK
// ============================================================
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool _selected = false;
  bool _chipVisible = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // SnackBar
        Seccion(
          titulo: 'SnackBar',
          descripcion: 'Notificación temporal en la parte inferior.',
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Guardado correctamente'),
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'Deshacer',
                    onPressed: () {},
                  ),
                ),
              );
            },
            child: const Text('Mostrar SnackBar'),
          ),
        ),

        // Progress indicators
        Seccion(
          titulo: 'CircularProgressIndicator / LinearProgressIndicator',
          descripcion: 'Indeterminado (giratorio) y determinado (65%).',
          child: Column(
            children: [
              const CircularProgressIndicator(
                color: Colors.indigo,
                strokeWidth: 3,
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: 0.65,
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
        ),

        // AlertDialog
        Seccion(
          titulo: 'AlertDialog',
          descripcion: 'Diálogo modal (barrierDismissible: false).',
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Confirmar'),
                  content: const Text('¿Estás seguro?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Aceptar'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Mostrar diálogo'),
          ),
        ),

        // Chip
        Seccion(
          titulo: 'Chip & FilterChip',
          descripcion: 'Etiquetas compactas, eliminables o seleccionables.',
          child: Wrap(
            spacing: 8,
            children: [
              if (_chipVisible)
                Chip(
                  label: const Text('Flutter'),
                  avatar: const CircleAvatar(child: Text('F')),
                  onDeleted: () => setState(() => _chipVisible = false),
                ),
              FilterChip(
                label: const Text('Dart'),
                selected: _selected,
                onSelected: (v) => setState(() => _selected = v),
              ),
              if (!_chipVisible)
                TextButton(
                  onPressed: () => setState(() => _chipVisible = true),
                  child: const Text('Restaurar chip'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
