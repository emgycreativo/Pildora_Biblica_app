import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventoPuntos {
  final String descripcion;
  final int puntos;
  final DateTime fecha;

  EventoPuntos({
    required this.descripcion,
    required this.puntos,
    required this.fecha,
  });
}

// ✅ LISTA GLOBAL accesible desde otros archivos
List<EventoPuntos> eventosPuntosGlobal = [
  EventoPuntos(
    descripcion: 'Entrada diaria',
    puntos: 10,
    fecha: DateTime(2025, 6, 23),
  ),
  EventoPuntos(
    descripcion: 'Compartió la app',
    puntos: 20,
    fecha: DateTime(2025, 6, 22),
  ),
  EventoPuntos(
    descripcion: 'Leyó el devocional',
    puntos: 15,
    fecha: DateTime(2025, 6, 21),
  ),
];

class HistorialPuntosScreen extends StatelessWidget {
  const HistorialPuntosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Puntos')),
      body: ListView.builder(
        itemCount: eventosPuntosGlobal.length,
        itemBuilder: (context, index) {
          final evento = eventosPuntosGlobal[index];
          final fecha = DateFormat(
            'dd MMM yyyy',
            'es_ES',
          ).format(evento.fecha).toUpperCase();
          return ListTile(
            leading: const Icon(Icons.star, color: Colors.orange),
            title: Text(evento.descripcion),
            subtitle: Text(fecha),
            trailing: Text(
              '+${evento.puntos} puntos',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
