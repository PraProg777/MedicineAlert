import 'package:flutter/material.dart';
import '../widgets/boton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesion')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Correo Electronico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Boton(
              texto: 'Ingresar',
              color: Colors.indigo,
              onPressed: () {
                print('Boton de ingreso presionado');
              },
            ),

            const SizedBox(height: 12),

            Boton(
              texto: 'Crear una cuenta',
              color: Colors.grey,
              onPressed: () {
                print('Ir a registro');
              },
            ),
          ],
        ),
      ),
    );
  }
}