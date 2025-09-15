import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/di/app_bindings.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        final auth = Get.find<AuthController>();

        if (auth.isLoggedIn) {
          Future.microtask(() => Get.offAllNamed(AppRoutes.home));
        }

        return child!;
      },
    );
  }
}
