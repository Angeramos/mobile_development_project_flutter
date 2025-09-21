import 'package:get/get.dart';

import 'package:mobile_development_project_flutter/core/services/roble_service.dart';
import 'package:mobile_development_project_flutter/features/auth/data/datasources/in_memory_auth_ds.dart';
import 'package:mobile_development_project_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_development_project_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_development_project_flutter/features/auth/presentation/controllers/auth_controller.dart';
import 'package:mobile_development_project_flutter/features/courses/presentation/controllers/courses_controller.dart';
import 'package:mobile_development_project_flutter/features/courses/data/repositories/course_local_repository.dart';
import 'package:mobile_development_project_flutter/features/categories/presentation/controllers/categories_controller.dart';
import 'package:mobile_development_project_flutter/features/categories/data/repositories/category_local_repository.dart';
import 'package:mobile_development_project_flutter/features/groups/presentation/controllers/groups_controller.dart';
import 'package:mobile_development_project_flutter/features/groups/data/repositories/group_local_repository.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(RobleService(), permanent: true);
    Get.lazyPut(() => InMemoryAuthDataSource());
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => CourseLocalRepository());
    Get.put(CoursesController(), permanent: true);
    Get.lazyPut(() => CategoryLocalRepository());
    Get.put(CategoriesController(), permanent: true);
    Get.lazyPut(() => GroupLocalRepository());
    Get.put(GroupsController(), permanent: true);
  }
}
