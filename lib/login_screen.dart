import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'registro_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _iniciarSesion() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PantallaBienvenida()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Error al iniciar sesión')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Píldora Bíblica'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 24),
              const Text(
                'Inicia sesión',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  filled: true,
                ),
                validator: (v) =>
                    v != null && v.contains('@') ? null : 'Correo inválido',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  filled: true,
                ),
                obscureText: true,
                validator: (v) =>
                    v != null && v.length >= 6 ? null : 'Contraseña muy corta',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4798ea),
                ),
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegistroScreen()),
                  );
                },
                child: const Text('¿No tienes una cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
