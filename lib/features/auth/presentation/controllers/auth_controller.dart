import 'package:get/get.dart';
import '../../../../core/services/roble_service.dart';

class AuthController extends GetxController {
  final Rxn<dynamic> _user = Rxn();
  dynamic get currentUser => _user.value;
  final RxBool loading = false.obs;
  final RxnString error = RxnString();
  final RxBool isLoggedIn = false.obs;

  final RobleService _roble = Get.find<RobleService>();

  Future<void> signIn(
    String email,
    String password, {
    bool keepLoggedIn = false,
  }) async {
    loading.value = true;
    error.value = null;
    final response = await _roble.login(
      email: email,
      password: password,
      keepLoggedIn: keepLoggedIn,
    );
    final success = response['success'] == true;
    isLoggedIn.value = success;
    loading.value = false;
    if (success) {
      _user.value = {
        'id': 'mock_id',
        'name': email.split('@')[0],
        'role': 'student',
      };
      Get.offAllNamed('/home');
    } else {
      error.value = response['message'] ?? "Usuario o contraseña incorrectos";
    }
  }

  Future<void> signOut() async {
    await _roble.logout();
    isLoggedIn.value = false;
    _user.value = null;
    Get.offAllNamed('/login');
  }

  Future<void> checkSession() async {
    isLoggedIn.value = await _roble.isLoggedIn();
  }
}
