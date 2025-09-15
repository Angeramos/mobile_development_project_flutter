import '../../domain/entities/user.dart';

class InMemoryAuthDataSource {
    AppUser? _current;

    Future<AppUser> signInDemo(String email) async {
    final user = AppUser(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: email.split('@').first,
        email: email,
        role: email.contains('prof') ? 'teacher' : 'student',
    );
    _current = user;
    return user;
    }

    Future<void> signOut() async {
    _current = null;
    }

    AppUser? currentUser() => _current;
}
