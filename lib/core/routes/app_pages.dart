import 'package:get/get.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/courses/presentation/pages/courses_page.dart';
import '../../features/courses/presentation/pages/my_courses_page.dart';
import '../../features/categories/presentation/pages/categories_page.dart';
import 'app_routes.dart';

class AppPages {
    static final routes = <GetPage>[
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(name: AppRoutes.courses, page: () => const CoursesPage()),
    GetPage(name: '/my-courses', page: () => const MyCoursesPage()),
    GetPage(name: AppRoutes.categories, page: () => const CategoriesPage()),
    ];
}
