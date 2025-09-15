import '../entities/user.dart';

abstract class AuthRepository {
    Future<AppUser> signInDemo({required String email});
    Future<void> signOut();
    AppUser? currentUser();
}
