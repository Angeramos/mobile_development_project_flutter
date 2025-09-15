import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/in_memory_auth_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
    final InMemoryAuthDataSource ds;
    AuthRepositoryImpl(this.ds);

    @override
    Future<AppUser> signInDemo({required String email}) => ds.signInDemo(email);

    @override
    Future<void> signOut() => ds.signOut();

    @override
    AppUser? currentUser() => ds.currentUser();
}
