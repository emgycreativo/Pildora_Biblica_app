import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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

  void _shareQuote() {
    Share.share(
      '"Bueno es el Señor con quienes esperan en él, con todos los que lo buscan."\nLAMENTACIONES 3:25',
    );
  }

  Widget _buildActionButton(String text, {Color textColor = Colors.yellow}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Bueno es el Señor con quienes esperan en él, con todos los que lo buscan.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Cita
        const Text(
          'LAMENTACIONES 3:25',
          style: TextStyle(
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
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _shareQuote,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'COMPARTE LA CITA',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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

  Widget _buildDevocionalView() {
    final fecha = DateFormat('dd MMM yyyy', 'es_ES').format(DateTime.now()).toUpperCase();
    return Container(
      key: const ValueKey('devocional'),
      color: Colors.yellow,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(flex: 2),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green.shade100,
              child: Icon(Icons.check, size: 50, color: Colors.green.shade700),
            ),
            const SizedBox(height: 16),
            const Text(
              '¡Cita marcada como leída!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              fecha,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'LAMENTACIONES 3:25',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.2,
              ),
            ),
            const Spacer(flex: 2),
            _buildActionButton('Leer Devocional', textColor: Colors.white),
            const SizedBox(height: 16),
            _buildActionButton('Canción del día', textColor: Colors.white),
            const SizedBox(height: 16),
            _buildActionButton('Diario de oración', textColor: Colors.white),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/fondo_amanecer.png', fit: BoxFit.cover),
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
                  ? _buildDevocionalView()
                  : _buildBienvenidaView(),
            ),
          ),
        ],
      ),
    );
  }
}
