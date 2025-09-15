import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/course.dart';

class CoursesController extends GetxController {
    final RxList<Course> courses = <Course>[].obs;
    final RxBool loading = false.obs;
    final RxnString error = RxnString();

    void addCourse(String name, String professorName) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final course = Course(
        id: id,
        name: name,
        professorName: professorName,
    );
    courses.add(course);
    }

    void enroll(String courseId) {
    final auth = Get.find<AuthController>();
    final user = auth.user.value;

    if (user == null) {
        error.value = "No hay usuario autenticado";
        return;
    }

    final index = courses.indexWhere((c) => c.id == courseId);
    if (index == -1) {
        error.value = "Curso no encontrado";
        return;
    }

    final course = courses[index];
    if (!course.enrolledUserIds.contains(user.id)) {
        final updated = course.copyWith(
        enrolledUserIds: [...course.enrolledUserIds, user.id],
        );
        courses[index] = updated;
    }
    }

    List<Course> listCourses() => courses.toList();
}
