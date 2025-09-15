import 'package:get/get.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
    final AuthRepository repo;
    AuthController(this.repo);

    final Rxn<AppUser> user = Rxn<AppUser>();
    final RxBool loading = false.obs;
    final RxnString error = RxnString();

    @override
    void onInit() {
    super.onInit();
    user.value = repo.currentUser();
    }

    Future<void> signInDemo(String email) async {
    loading.value = true;
    error.value = null;
    try {
        final u = await repo.signInDemo(email: email);
        user.value = u;
        Get.offAllNamed('/home');
    } catch (e) {
        error.value = e.toString();
    } finally {
        loading.value = false;
    }
    }

Future<void> signOut() async {
    await repo.signOut();
    user.value = null;
    Get.offAllNamed('/login');
    }

    bool get isLoggedIn => user.value != null;
}
