import 'package:flutter/material.dart';
import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';
import 'pantalla_principal.dart';
import 'custom_button.dart';
import 'registro_screen.dart';

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
      home: const RegistroScreen(),
    );
  }
}

class PantallaBienvenida extends StatefulWidget {
  const PantallaBienvenida({super.key});

  @override
  State<PantallaBienvenida> createState() => _PantallaBienvenidaState();
}

class _PantallaBienvenidaState extends State<PantallaBienvenida>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  bool _overlayDismissed = false;
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final String _background;
  late final String _overlayBackground;
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
    _overlayBackground = fondos[random.nextInt(fondos.length)];
    _versiculo = versiculos[random.nextInt(versiculos.length)];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _checkDailyPoints();
  }

  Future<void> _checkDailyPoints() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final lastOpen = prefs.getString('lastOpenDate');
    final total = prefs.getInt('totalPoints') ?? 0;
    if (lastOpen != today) {
      await prefs.setString('lastOpenDate', today);
      await prefs.setInt('totalPoints', total + 10);
      if (mounted) {
        // Mensaje visual cuando se otorgan los puntos
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Ganaste 10 puntos por entrar hoy!')),
        );
      }
      print('¡Ganaste 10 puntos por entrar hoy!');
    }
  }

  void _shareQuote() {
    Share.share('"${_versiculo['texto']}"\n${_versiculo['cita']}');
  }

  void _dismissOverlay() {
    _controller.forward().then((_) {
      if (mounted) {
        setState(() => _overlayDismissed = true);
      }
    });
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
          onPressed: _dismissOverlay,
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_background, fit: BoxFit.cover),
          const SafeArea(child: PantallaPrincipal()),
          if (!_overlayDismissed)
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_overlayBackground),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(child: _buildBienvenidaView()),
              ),
            ),
        ],
      ),
    );
  }
}
