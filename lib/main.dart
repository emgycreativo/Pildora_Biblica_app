import 'dart:math';
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'devocional_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Píldora Bíblica',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const PantallaBienvenida(),
    );
  }
}

class PantallaBienvenida extends StatefulWidget {
  const PantallaBienvenida({super.key});

  @override
  State<PantallaBienvenida> createState() => _PantallaBienvenidaState();
}

class _PantallaBienvenidaState extends State<PantallaBienvenida> {
  late Map<String, String> _versiculo;
  late String _fondo;

  final _versiculos = [
    {
      'cita': 'Jeremías 29:11',
      'texto':
          'Porque yo sé los planes que tengo para ustedes \u2014afirma el Señor\u2014, planes de bienestar y no de calamidad, a fin de darles un futuro y una esperanza.'
    },
    {
      'cita': 'Salmos 23:1',
      'texto': 'El Señor es mi pastor, nada me faltará.'
    },
    {
      'cita': 'Filipenses 4:13',
      'texto': 'Todo lo puedo en Cristo que me fortalece.'
    }
  ];

  final _fondos = [
    'assets/fondo1_pb_t1.jpg',
    'assets/fondo2_pb_t1.jpg',
    'assets/fondo3_pb_t1.jpg',
  ];

  @override
  void initState() {
    super.initState();
    final rnd = Random();
    _versiculo = _versiculos[rnd.nextInt(_versiculos.length)];
    _fondo = _fondos[rnd.nextInt(_fondos.length)];
  }

  Route _crearRutaDevocional() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => DevocionalScreen(
        cita: _versiculo['cita']!,
        versiculo: _versiculo['texto']!,
      ),
      transitionsBuilder: (_, animation, __, child) {
        final offset = Tween(begin: const Offset(0, -1), end: Offset.zero)
            .animate(animation);
        return SlideTransition(position: offset, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_fondo, fit: BoxFit.cover),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Image.asset('assets/logo_pildora.png', width: 100),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    _versiculo['texto']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _versiculo['cita']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).push(_crearRutaDevocional()),
                    child: const Text('TOCA AQUÍ PARA CONCLUIR'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
