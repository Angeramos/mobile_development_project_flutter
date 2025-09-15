import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/courses_controller.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class CoursesPage extends GetView<CoursesController> {
    const CoursesPage({super.key});

    @override
    Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Scaffold(
        appBar: AppBar(title: const Text('Cursos')),
        body: Obx(() {
        if (controller.courses.isEmpty) {
            return const Center(child: Text("No hay cursos"));
        }
        return ListView.builder(
            itemCount: controller.courses.length,
            itemBuilder: (_, i) {
            final course = controller.courses[i];
            return ListTile(
                title: Text(course.name),
                subtitle: Text(
                'Profesor: ${course.professorName} • Inscritos: ${course.enrolledUserIds.length}',
                ),
                trailing: IconButton(
                icon: const Icon(Icons.person_add),
                onPressed: () {
                    controller.enroll(course.id);
                    Get.snackbar("Inscripción",
                        "${auth.user.value?.name} inscrito en ${course.name}");
                },
                ),
            );
            },
        );
        }),
        floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
            final now = DateTime.now().millisecondsSinceEpoch.toString();
            controller.addCourse("Curso $now", auth.user.value?.name ?? "Profesor");
        },
        ),
    );
    }
}
