import 'dart:convert';
import 'package:http/http.dart' as http;

class RobleService {
  static const String _baseAuthUrl =
      'https://roble-api.openlab.uninorte.edu.co/auth';
  static const String _baseDatabaseUrl =
      'https://roble-api.openlab.uninorte.edu.co/database';
  static const String _dbName = 'courseven_66a52df881';

  Map<String, String> get _baseHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> _authHeaders(String token) => {
    ..._baseHeaders,
    'Authorization': 'Bearer $token',
  };

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    bool keepLoggedIn = false,
  }) async {
    final url = '$_baseAuthUrl/$_dbName/login';
    final response = await http.post(
      Uri.parse(url),
      headers: _baseHeaders,
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return {
        'success': true,
        'accessToken': data['accessToken'],
        'refreshToken': data['refreshToken'],
        'access_token': data['accessToken'],
        'refresh_token': data['refreshToken'],
        'data': data['user'],
        'user': data['user'],
      };
    } else {
      return {'success': false};
    }
  }

  Future<void> logout() async {
    return;
  }

  Future<bool> isLoggedIn() async {
    return false;
  }

  Future<Map<String, dynamic>> verifyToken({
    required String accessToken,
  }) async {
    final url = '$_baseAuthUrl/$_dbName/verify-token';
    final response = await http.get(
      Uri.parse(url),
      headers: _authHeaders(accessToken),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data is Map<String, dynamic>
          ? data
          : {'valid': true, 'data': data};
    } else {
      return {'valid': false};
    }
  }

  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    final url = '$_baseAuthUrl/$_dbName/signup';
    final response = await http.post(
      Uri.parse(url),
      headers: _baseHeaders,
      body: jsonEncode({'email': email, 'password': password, 'name': name}),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String code,
  }) async {
    final url = '$_baseAuthUrl/$_dbName/verify-email';
    final response = await http.post(
      Uri.parse(url),
      headers: _baseHeaders,
      body: jsonEncode({'email': email, 'code': code}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (response.statusCode == 201 && data.containsKey('message')) {
        data['success'] = true;
      }
      return data;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> signupDirect({
    required String email,
    required String password,
    required String name,
  }) async {
    final url = '$_baseAuthUrl/$_dbName/signup-direct';
    final response = await http.post(
      Uri.parse(url),
      headers: _baseHeaders,
      body: jsonEncode({'email': email, 'password': password, 'name': name}),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> createUserInDatabase({
    required String accessToken,
    required String email,
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    String? studentId,
  }) async {
    final url = '$_baseDatabaseUrl/$_dbName/insert';
    final response = await http.post(
      Uri.parse(url),
      headers: _authHeaders(accessToken),
      body: jsonEncode({
        'tableName': 'users',
        'records': [
          {
            'email': email,
            'first_name': firstName,
            'last_name': lastName,
            'username': username,
            'key_password': password,
            'student_id': studentId ?? '',
            'is_active': true,
            'created_at': DateTime.now().toIso8601String(),
          },
        ],
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final inserted = data['inserted'];
      if (inserted is List && inserted.isNotEmpty) {
        return data;
      }
      return {};
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    return {
      'success': true,
      'data': {
        'id': 'temp_user_id',
        'email': 'temp@example.com',
        'firstName': 'Usuario',
        'lastName': 'Temporal',
        'username': 'temp_user',
        'created_at': DateTime.now().toIso8601String(),
      },
    };
  }

  Future<Map<String, dynamic>?> getUserFromDatabase({
    required String accessToken,
    required String email,
  }) async {
    final url = '$_baseDatabaseUrl/$_dbName/read';
    final response = await http.get(
      Uri.parse('$url?tableName=users&email=$email'),
      headers: _authHeaders(accessToken),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty) {
        return data[0];
      }
      return null;
    } else {
      return null;
    }
  }
}
