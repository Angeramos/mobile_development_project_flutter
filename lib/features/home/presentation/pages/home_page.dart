import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../courses/presentation/pages/courses_page.dart';
import '../../../categories/presentation/pages/categories_page.dart';

class HomePage extends GetView<AuthController> {
    const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Home'),
        actions: [
            IconButton(
            onPressed: controller.signOut,
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            ),
        ],
        ),
        body: Obx(() {
        final user = controller.user.value;
        if (user == null) {
            return const Center(
            child: Text('No hay usuario (debería redirigir a login)'),
            );
        }

        return Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text('Bienvenid@, ${user.name} (${user.role})'),
                const SizedBox(height: 24),
                ElevatedButton(
                onPressed: () => Get.to(() => const CoursesPage()),
                child: const Text("Ver Cursos"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                onPressed: () => Get.to(() => const CategoriesPage()),
                child: const Text("Ver Categorías"),
                ),
            ],
            ),
        );
        }),
    );
    }
}
