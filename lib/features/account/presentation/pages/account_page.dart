import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final user = authController.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Cuenta'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.email ?? 'Usuario',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (user != null)
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: Icon(Icons.star, color: Colors.orange),
                title: const Text('Promedio'),
                subtitle: const Text('8.5'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.workspace_premium, color: Colors.purple),
                title: const Text('Certificados'),
                subtitle: const Text('3'),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => authController.signOut(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
