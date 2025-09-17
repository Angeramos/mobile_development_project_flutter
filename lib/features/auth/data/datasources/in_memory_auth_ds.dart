import 'package:get_storage/get_storage.dart';
import '../../../../core/storage/storage_service.dart';
import '../../domain/entities/user.dart';

class InMemoryAuthDataSource {
    final GetStorage _db = StorageService.db();
    final GetStorage _auth = StorageService.auth();

    AppUser? _current;

    AppUser? currentUser() {
    // intenta recuperar sesión recordada
    final saved = _auth.read('remembered_user') as Map?;
    if (_current == null && saved != null) {
        _current = AppUser(
        id: saved['id'],
        name: saved['name'],
        email: saved['email'],
        role: saved['role'],
        );
    }
    return _current;
    }

    Future<AppUser> signInWithEmailPassword({
    required String email,
    required String password,
    required bool remember,
    }) async {
    final users = List<Map<String, dynamic>>.from(_db.read('users') ?? []);
    final match = users.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
        orElse: () => {},
    );
    if (match.isEmpty) {
        throw Exception('Credenciales inválidas');
    }
    final user = AppUser(
        id: match['id'],
        name: match['name'],
        email: match['email'],
        role: match['role'],
    );
    _current = user;

    if (remember) {
        _auth.write('remembered_user', {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'role': user.role,
        });
        _auth.write('remember_me', true);
    } else {
        _auth.remove('remembered_user');
        _auth.write('remember_me', false);
    }

    return user;
    }

    Future<void> signOut() async {
    _current = null;
    final remember = _auth.read('remember_me') == true;
    if (!remember) {
        _auth.remove('remembered_user');
    }
    }

    bool getRememberMeFlag() => _auth.read('remember_me') == true;

    void setRememberMeFlag(bool value) => _auth.write('remember_me', value);
}
