import 'package:flutter/material.dart';

class CitaConfirmada extends StatelessWidget {
  final String cita;
  final String fecha;

  const CitaConfirmada({
    super.key,
    this.cita = 'LAMENTACIONES 3:25',
    this.fecha = '21 JUN 2025',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6EF),
      body: SafeArea(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 40 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.green.shade50,
                  child: Icon(
                    Icons.check,
                    size: 56,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '¡Cita marcada como leída!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  fecha.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cita,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(flex: 2),
                const _BotonAccion(texto: 'LEER DEVOCIONAL'),
                const SizedBox(height: 16),
                const _BotonAccion(texto: 'Canción del día'),
                const SizedBox(height: 16),
                const _BotonAccion(texto: 'Diario de oración'),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BotonAccion extends StatelessWidget {
  final String texto;

  const _BotonAccion({required this.texto});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          texto,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
