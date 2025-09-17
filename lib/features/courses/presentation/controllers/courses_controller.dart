import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/course.dart';
import '../../data/repositories/course_local_repository.dart';

class CoursesController extends GetxController {
  final RxList<Course> courses = <Course>[].obs;
  final RxBool loading = false.obs;
  final RxnString error = RxnString();

  final _repo = CourseLocalRepository();

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  void _loadFromStorage() {
    final raw = _repo.listAll();
    final parsed = raw
        .map(
          (m) => Course(
            id: m['id'],
            name: m['name'],
            professorName: m['professorName'],
            enrolledUserIds: List<String>.from(m['enrolledUserIds'] ?? []),
          ),
        )
        .toList();
    courses.assignAll(parsed);
  }

  void addCourse(String name, String professorName) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final course = Course(id: id, name: name, professorName: professorName);
    courses.add(course);
    _repo.create({
      'id': course.id,
      'name': course.name,
      'professorName': course.professorName,
      'code': _generateCode(),
      'enrolledUserIds': course.enrolledUserIds,
    });
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
      _repo.enrollUser(courseId, user.id);
    }
  }

  bool enrollByCode(String code) {
    final auth = Get.find<AuthController>();
    final user = auth.user.value;
    if (user == null) {
      error.value = "No hay usuario autenticado";
      return false;
    }
    final raw = _repo.getByCode(code);
    if (raw == null) {
      error.value = "Código inválido";
      return false;
    }
    _repo.enrollUser(raw['id'], user.id);
    _loadFromStorage();
    return true;
  }

  List<Course> listCourses() => courses.toList();

  String _generateCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final now = DateTime.now().millisecondsSinceEpoch;
    return [
      chars[now % chars.length],
      chars[(now ~/ 7) % chars.length],
      chars[(now ~/ 13) % chars.length],
      chars[(now ~/ 17) % chars.length],
      chars[(now ~/ 19) % chars.length],
      chars[(now ~/ 23) % chars.length],
    ].join();
  }
}
