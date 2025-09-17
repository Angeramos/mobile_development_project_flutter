import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
    const LoginPage({super.key});

    @override
    Widget build(BuildContext context) {
    final emailCtrl = TextEditingController(text: 'a@a.com');   // usuario demo profe
    final passCtrl  = TextEditingController(text: '123456');

    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
            return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                controller: passCtrl,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                ),
                const SizedBox(height: 8),
                Row(
                children: [
                    Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: (v) => controller.toggleRemember(v ?? false),
                    ),
                    const Text('Recordarme'),
                ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                onPressed: controller.loading.value
                    ? null
                    : () => controller.signIn(emailCtrl.text.trim(), passCtrl.text.trim()),
                child: controller.loading.value
                    ? const CircularProgressIndicator()
                    : const Text('Iniciar sesión'),
                ),
                if (controller.error.value != null) ...[
                const SizedBox(height: 12),
                Text('Error: ${controller.error.value}', style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 24),
                const Text('Usuarios de prueba:\n'
                    'a@a.com / 123456 (profe, dueño de “curso1”)\n'
                    'b@a.com / 123456 (estudiante inscrito en “curso1”)\n'
                    'c@a.com / 123456 (sin cursos)'),
            ],
            );
        }),
        ),
    );
    }
}
