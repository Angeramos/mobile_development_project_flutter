import 'package:get/get.dart';
import '../../features/auth/data/datasources/in_memory_auth_ds.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/courses/presentation/controllers/courses_controller.dart';
import '../../features/categories/presentation/controllers/categories_controller.dart';

class AppBindings extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut(() => InMemoryAuthDataSource());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.put(AuthController(Get.find()), permanent: true);
    Get.put(CoursesController(), permanent: true);
    Get.put(CategoriesController(), permanent: true);
    }
}
