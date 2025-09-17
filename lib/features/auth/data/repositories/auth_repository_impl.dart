import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/in_memory_auth_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final InMemoryAuthDataSource ds;
  AuthRepositoryImpl(this.ds);

  @override
  AppUser? currentUser() => ds.currentUser();

  @override
  Future<void> signOut() => ds.signOut();

  @override
  Future<AppUser> signInDemo({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<AppUser> signInWithPassword({
    required String email,
    required String password,
    required bool remember,
  }) => ds.signInWithEmailPassword(
    email: email,
    password: password,
    remember: remember,
  );

  @override
  bool getRememberMeFlag() => ds.getRememberMeFlag();
  @override
  void setRememberMeFlag(bool v) => ds.setRememberMeFlag(v);
}
