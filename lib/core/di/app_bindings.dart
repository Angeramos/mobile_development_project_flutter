import 'package:get/get.dart';
import '../../features/auth/data/datasources/in_memory_auth_ds.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/courses/presentation/controllers/courses_controller.dart';
import '../../features/courses/data/repositories/course_local_repository.dart';
import '../../features/categories/presentation/controllers/categories_controller.dart';
import '../../features/categories/data/repositories/category_local_repository.dart';
import '../../features/groups/presentation/controllers/groups_controller.dart';
import '../../features/groups/data/repositories/group_local_repository.dart';

class AppBindings extends Bindings {
    @override
    void dependencies() {
    // Auth
    Get.lazyPut(() => InMemoryAuthDataSource());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.put(AuthController(Get.find()), permanent: true);

    // Courses + repos
    Get.lazyPut(() => CourseLocalRepository());
    Get.put(CoursesController(), permanent: true);

    // Categories + repos
    Get.lazyPut(() => CategoryLocalRepository());
    Get.put(CategoriesController(), permanent: true);

    // Groups + repos
    Get.lazyPut(() => GroupLocalRepository());
    Get.put(GroupsController(), permanent: true);
    }
}
