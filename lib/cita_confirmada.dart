import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_button.dart';

class CitaConfirmada extends StatefulWidget {
  const CitaConfirmada({super.key});

  @override
  State<CitaConfirmada> createState() => _CitaConfirmadaState();
}

class _CitaConfirmadaState extends State<CitaConfirmada> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final fecha = DateFormat('dd MMM yyyy', 'es_ES').format(DateTime.now()).toUpperCase();
    final hora = DateFormat('HH:mm').format(DateTime.now());

    Widget quickAction(IconData icon, String label, String duration) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.black87),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(duration, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
      );
    }

    Widget essentialsAction(IconData icon, String label, String duration) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(duration, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('PLUS', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Text(hora, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const Text('Acércate a Dios', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  const CircleAvatar(radius: 18, child: Icon(Icons.person)),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.group),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(fecha, style: TextStyle(color: Colors.grey.shade600)),
                          const SizedBox(height: 8),
                          const Text(
                            'Moisés, el que venció sus temores',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.local_offer, color: Colors.orange.shade300, size: 20),
                              const SizedBox(width: 4),
                              const Text('Cita Diaria'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('LA CITA DE HOY ES DE:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          const SizedBox(height: 4),
                          const Text(
                            'Lamentaciones 3:25',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(height: 12),
                          AppButton(text: 'LEER', onPressed: () {}),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        quickAction(Icons.menu_book, 'Pasaje', '1 min'),
                        quickAction(Icons.chat_bubble_outline, 'Devocional', '5 min'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'ESENCIALES DE LA FE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    essentialsAction(Icons.music_note, 'Canción del día', '5 min'),
                    essentialsAction(Icons.emoji_emotions, 'Declaraciones', '3 min'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Hoy'),
          BottomNavigationBarItem(icon: Icon(Icons.headphones), label: 'Explora'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Biblia'),
          BottomNavigationBarItem(icon: Icon(Icons.handshake), label: 'Oraciones'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Diario'),
        ],
      ),
    );
  }
}
