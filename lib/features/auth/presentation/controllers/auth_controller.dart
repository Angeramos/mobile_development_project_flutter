import 'package:get/get.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
    final AuthRepository repo;
    AuthController(this.repo);

    final Rxn<AppUser> user = Rxn<AppUser>();
    final RxBool loading = false.obs;
    final RxnString error = RxnString();
    final RxBool rememberMe = false.obs;

    @override
    void onInit() {
    super.onInit();
    user.value = repo.currentUser();
    rememberMe.value = repo.getRememberMeFlag();
    }

    Future<void> signIn(String email, String password) async {
    loading.value = true;
    error.value = null;
    try {
        final u = await repo.signInWithPassword(
        email: email,
        password: password,
        remember: rememberMe.value,
        );
        user.value = u;
        Get.offAllNamed('/home');
    } catch (e) {
        error.value = e.toString();
    } finally {
        loading.value = false;
    }
    }

    void toggleRemember(bool v) {
    rememberMe.value = v;
    repo.setRememberMeFlag(v);
    }

    Future<void> signOut() async {
    await repo.signOut();
    user.value = null;
    Get.offAllNamed('/login');
    }

    bool get isLoggedIn => user.value != null;
}
