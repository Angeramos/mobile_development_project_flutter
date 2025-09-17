import '../entities/user.dart';

abstract class AuthRepository {
    Future<AppUser> signInDemo({required String email});
    Future<void> signOut();
    AppUser? currentUser();
    Future<AppUser> signInWithPassword({required String email, required String password, required bool remember});
    bool getRememberMeFlag();
    void setRememberMeFlag(bool value);
    }