import 'package:flutter/material.dart';
import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app_theme.dart';
import 'cita_confirmada.dart';
import 'custom_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
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
  bool _isFavorite = false;
  bool _mostrarDevocional = false;
  late final String _background;
  late final Map<String, String> _versiculo;

  @override
  void initState() {
    super.initState();
    final random = Random();
    final fondos = [
      'assets/fondo1_pb_t1.jpg',
      'assets/fondo2_pb_t1.jpg',
      'assets/fondo3_pb_t1.jpg',
    ];
    final versiculos = [
      {
        'texto':
            'Porque yo sé los planes que tengo para ustedes —afirma el Señor—, planes de bienestar y no de calamidad, a fin de darles un futuro y una esperanza.',
        'cita': 'JEREMÍAS 29:11',
      },
      {
        'texto': 'El Señor es mi pastor, nada me faltará.',
        'cita': 'SALMOS 23:1',
      },
      {
        'texto': 'Todo lo puedo en Cristo que me fortalece.',
        'cita': 'FILIPENSES 4:13',
      },
    ];
    _background = fondos[random.nextInt(fondos.length)];
    _versiculo = versiculos[random.nextInt(versiculos.length)];
  }

  void _shareQuote() {
    Share.share('"${_versiculo['texto']}"\n${_versiculo['cita']}');
  }


  Widget _buildBienvenidaView() {
    return Column(
      key: const ValueKey('bienvenida'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),

        // Logo
        Image.asset('assets/logo_pildora.png', width: 100),
        const SizedBox(height: 16),

        // Texto de la cita
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

        // Cita
        Text(
          _versiculo['cita']!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        // Icono de corazón
        IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : Colors.white,
          ),
          iconSize: 30,
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
        ),

        const Spacer(),

        // Botón "Comparte la cita"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: AppButton(
            text: 'COMPARTE LA CITA',
            onPressed: _shareQuote,
            icon: Icons.share,
          ),
        ),

        const SizedBox(height: 12),

        // Texto "Toca aquí para concluir"
        TextButton(
          onPressed: () {
            setState(() {
              _mostrarDevocional = true;
            });
          },
          child: const Text(
            'TOCA AQUÍ PARA CONCLUIR',
            style: TextStyle(color: Colors.white),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_background, fit: BoxFit.cover),
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: _mostrarDevocional
                  ? const CitaConfirmada()
                  : _buildBienvenidaView(),
            ),
          ),
        ],
      ),
    );
  }
}
