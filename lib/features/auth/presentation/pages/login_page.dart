import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
    const LoginPage({super.key});

    @override
    Widget build(BuildContext context) {
    final emailCtrl = TextEditingController(text: 'prof@uni.edu'); // demo

    return Scaffold(
        appBar: AppBar(title: const Text('Login (Demo)')),
        body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
            return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                    labelText: 'Email (usa "prof" para rol teacher)',
                ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                onPressed: controller.loading.value
                    ? null
                    : () => controller.signInDemo(emailCtrl.text.trim()),
                child: controller.loading.value
                    ? const CircularProgressIndicator()
                    : const Text('Iniciar sesión'),
                ),
                if (controller.error.value != null) ...[
                const SizedBox(height: 12),
                Text('Error: ${controller.error.value}', style: const TextStyle(color: Colors.red)),
                ],
            ],
            );
        }),
        ),
    );
    }
}
