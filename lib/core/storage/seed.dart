import 'storage_service.dart';

Future<void> seedIfEmpty() async {
  final db = StorageService.db();

  final users = List<Map<String, dynamic>>.from(db.read('users') ?? []);
  final courses = List<Map<String, dynamic>>.from(db.read('courses') ?? []);

  if (users.isEmpty && courses.isEmpty) {
    final seedUsers = [
      {
        'id': 'u_a',
        'email': 'a@a.com',
        'password': '123456',
        'name': 'A Profe',
        'role': 'teacher',
      },
      {
        'id': 'u_b',
        'email': 'b@a.com',
        'password': '123456',
        'name': 'B Student',
        'role': 'student',
      },
      {
        'id': 'u_c',
        'email': 'c@a.com',
        'password': '123456',
        'name': 'C Student',
        'role': 'student',
      },
      {
        'id': 'u_d',
        'email': 'd@a.com',
        'password': '123456',
        'name': 'D Student',
        'role': 'student',
      },
      {
        'id': 'u_e',
        'email': 'e@a.com',
        'password': '123456',
        'name': 'E Student',
        'role': 'student',
      },
      {
        'id': 'u_f',
        'email': 'f@a.com',
        'password': '123456',
        'name': 'F Student',
        'role': 'student',
      },
      {
        'id': 'u_g',
        'email': 'g@a.com',
        'password': '123456',
        'name': 'G Student',
        'role': 'student',
      },

      {
        'id': 'u_ab',
        'email': 'a@b.com',
        'password': '123456',
        'name': 'A2 Student',
        'role': 'student',
      },
      {
        'id': 'u_bb',
        'email': 'b@b.com',
        'password': '123456',
        'name': 'B2 Student',
        'role': 'student',
      },
      {
        'id': 'u_cb',
        'email': 'c@b.com',
        'password': '123456',
        'name': 'C2 Student',
        'role': 'student',
      },
      {
        'id': 'u_db',
        'email': 'd@b.com',
        'password': '123456',
        'name': 'D2 Student',
        'role': 'student',
      },
      {
        'id': 'u_eb',
        'email': 'e@b.com',
        'password': '123456',
        'name': 'E2 Student',
        'role': 'student',
      },
      {
        'id': 'u_fb',
        'email': 'f@b.com',
        'password': '123456',
        'name': 'F2 Student',
        'role': 'student',
      },
      {
        'id': 'u_gb',
        'email': 'g@b.com',
        'password': '123456',
        'name': 'G2 Student',
        'role': 'student',
      },
    ];

    final curso1 = {
      'id': 'c_1',
      'name': 'curso1',
      'professorName': 'A Profe',
      'code': 'ABC123',
      'enrolledUserIds': ['u_a', 'u_b', 'u_c', 'u_d', 'u_e', 'u_f', 'u_g'],
    };

    final cat1 = {
      'id': 'cat_1',
      'name': 'Investigación',
      'groupingMethod': 'selfAssigned',
      'maxMembers': 3,
      'courseId': 'c_1',
    };

    final group1 = {
      'id': 'g_1',
      'courseId': 'c_1',
      'categoryId': 'cat_1',
      'name': 'Grupo Investigación 1',
      'memberIds': ['u_b', 'u_c'],
    };

    db.write('users', seedUsers);
    db.write('courses', [curso1]);
    db.write('categories', [cat1]);
    db.write('groups', [group1]);
  } else {
    if (db.read('users') == null) db.write('users', []);
    if (db.read('courses') == null) db.write('courses', []);
    if (db.read('categories') == null) db.write('categories', []);
    if (db.read('groups') == null) db.write('groups', []);
  }
}
