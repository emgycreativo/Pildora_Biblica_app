import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_button.dart';
import 'historial_puntos.dart' as puntos;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InvitarAmigoScreen extends StatefulWidget {
  const InvitarAmigoScreen({super.key});

  @override
  State<InvitarAmigoScreen> createState() => _InvitarAmigoScreenState();
}

class _InvitarAmigoScreenState extends State<InvitarAmigoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _telefonoCtrl.dispose();
    _correoCtrl.dispose();
    super.dispose();
  }

  Future<void> _sumarPuntos() async {
    final prefs = await SharedPreferences.getInstance();
    final total = prefs.getInt('totalPoints') ?? 0;
    await prefs.setInt('totalPoints', total + 20);
    puntos.eventosPuntosGlobal.insert(
      0,
      puntos.EventoPuntos(
        descripcion: 'Compartió la app',
        puntos: 20,
        fecha: DateTime.now(),
      ),
    );
  }

  Future<void> _compartirWhatsApp(String mensaje) async {
    final url = Uri.parse(
      'https://wa.me/${_telefonoCtrl.text}?text=${Uri.encodeComponent(mensaje)}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      await _sumarPuntos();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Gracias por compartir! +20 puntos'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _mostrarError();
    }
  }

  Future<void> _compartirSms(String mensaje) async {
    final url = Uri.parse(
      'sms:${_telefonoCtrl.text}?body=${Uri.encodeComponent(mensaje)}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      await _sumarPuntos();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Gracias por compartir! +20 puntos'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _mostrarError();
    }
  }

  Future<void> _compartirCorreo(String mensaje) async {
    final correo = _correoCtrl.text;
    final url = Uri.parse(
      'mailto:$correo?subject=Invitaci%C3%B3n&body=${Uri.encodeComponent(mensaje)}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      await _sumarPuntos();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Gracias por compartir! +20 puntos'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _mostrarError();
    }
  }

  void _mostrarError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No se pudo compartir la invitación')),
    );
  }

  void _mostrarOpciones(String mensaje) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.green,
                ),
                title: const Text('WhatsApp'),
                onTap: () {
                  Navigator.pop(context);
                  _compartirWhatsApp(mensaje);
                },
              ),
              ListTile(
                leading: const Icon(Icons.sms, color: Colors.blue),
                title: const Text('SMS'),
                onTap: () {
                  Navigator.pop(context);
                  _compartirSms(mensaje);
                },
              ),
              if (_correoCtrl.text.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.orange),
                  title: const Text('Correo electrónico'),
                  onTap: () {
                    Navigator.pop(context);
                    _compartirCorreo(mensaje);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _enviarInvitacion() {
    if (!_formKey.currentState!.validate()) return;
    final mensaje =
        'Hola ${_nombreCtrl.text}, te invito a usar esta app devocional que me ha ayudado mucho a acercarme a Dios. ¡Descárgala aquí! https://ejemplo.com';
    _mostrarOpciones(mensaje);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invitar a un amigo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre del amigo',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _telefonoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Número de celular',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _correoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico (opcional)',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Compartir invitación',
                onPressed: _enviarInvitacion,
                icon: Icons.share,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
