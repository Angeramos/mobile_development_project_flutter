import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/courses_controller.dart';

class MyCoursesPage extends StatelessWidget {
  const MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final coursesCtrl = Get.find<CoursesController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Mis Cursos")),
      body: Obx(() {
        final user = auth.currentUser;
        if (user == null) {
          return const Center(child: Text("Debes iniciar sesión"));
        }

        final myCourses = coursesCtrl.courses
            .where((c) => c.enrolledUserIds.contains(user.id))
            .toList();

        if (myCourses.isEmpty) {
          return const Center(child: Text("No estás inscrito en ningún curso"));
        }

        return ListView.builder(
          itemCount: myCourses.length,
          itemBuilder: (_, i) {
            final course = myCourses[i];
            return ListTile(
              title: Text(course.name),
              subtitle: Text("Profesor: ${course.professorName}"),
              trailing: Text("Inscritos: ${course.enrolledUserIds.length}"),
            );
          },
        );
      }),
    );
  }
}
