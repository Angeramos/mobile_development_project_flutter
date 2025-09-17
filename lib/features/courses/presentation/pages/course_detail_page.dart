import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/course.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;
  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final isTeacher = auth.user.value?.role == 'teacher';

    return Scaffold(
      appBar: AppBar(title: Text(course.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text('Profesor: ${course.professorName}'),
            subtitle: Text('Inscritos: ${course.enrolledUserIds.length}'),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Estudiantes inscritos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: course.enrolledUserIds.length,
              itemBuilder: (_, i) => ListTile(
                leading: const Icon(Icons.person),
                title: Text(course.enrolledUserIds[i]),
              ),
            ),
          ),
          if (!isTeacher)
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.snackbar(
                    'Info',
                    'Desde aquí entraremos a grupos del curso.',
                  );
                },
                icon: const Icon(Icons.group),
                label: const Text('Ver grupos del curso'),
              ),
            ),
        ],
      ),
    );
  }
}
