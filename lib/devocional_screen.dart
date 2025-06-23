import 'package:flutter/material.dart';

class DevocionalScreen extends StatefulWidget {
  final String cita;
  final String versiculo;

  const DevocionalScreen({
    Key? key,
    required this.cita,
    required this.versiculo,
  }) : super(key: key);

  @override
  State<DevocionalScreen> createState() => _DevocionalScreenState();
}

class _DevocionalScreenState extends State<DevocionalScreen> {
  bool _leido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Devocional diario')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cita,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(widget.versiculo),
            const SizedBox(height: 8),
            ExpansionTile(
              title: const Text('Devocional'),
              children: [
                const Text(
                  'Fortaleza en Cristo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A veces sentimos que nuestras fuerzas no son suficientes para los desafíos del día. Las preocupaciones, los problemas o nuestras propias limitaciones nos hacen dudar.',
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pero este versículo nos recuerda que nuestra verdadera fortaleza viene de Cristo. No se trata solo de aguantar, sino de avanzar con fe sabiendo que Él nos da poder más allá de nuestras capacidades. Hoy, respira profundo, y dile a Dios: "Contigo, puedo hacerlo".',
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _leido
                        ? null
                        : () {
                            setState(() {
                              _leido = true;
                            });
                          },
                    child: _leido
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Text('Marcar como leído'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
