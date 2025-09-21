import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/di/app_bindings.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'core/storage/storage_service.dart';
import 'core/storage/seed.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/account/account_page.dart';
import 'presentation/pages/calendar/calendar_page.dart';
import 'presentation/pages/settings/settings_page.dart';
import 'presentation/widgets/bottom_navigation_dock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await seedIfEmpty();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2F6BFF),
      ),
      builder: (context, child) {
        return child!;
      },
    );
  }
}

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String account = '/account';
  static const String calendar = '/calendar';
  static const String settings = '/settings';
}

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(name: AppRoutes.account, page: () => const AccountPage()),
    GetPage(name: AppRoutes.calendar, page: () => const CalendarPage()),
    GetPage(name: AppRoutes.settings, page: () => const SettingsPage()),
  ];
}
