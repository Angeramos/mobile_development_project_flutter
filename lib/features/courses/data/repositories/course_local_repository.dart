import 'package:get_storage/get_storage.dart';
import '../../../../core/storage/storage_service.dart';

class CourseLocalRepository {
    final GetStorage _db = StorageService.db();

    List<Map<String, dynamic>> _readAll() =>
        List<Map<String, dynamic>>.from(_db.read('courses') ?? []);

    void _writeAll(List<Map<String, dynamic>> data) => _db.write('courses', data);

    List<Map<String, dynamic>> listAll() => _readAll();

    Map<String, dynamic>? getById(String id) {
    final all = _readAll();
    try {
        return all.firstWhere((c) => c['id'] == id);
    } catch (_) {
        return null;
    }
    }

    void create(Map<String, dynamic> course) {
    final all = _readAll();
    all.add(course);
    _writeAll(all);
    }

    void update(Map<String, dynamic> course) {
    final all = _readAll();
    final idx = all.indexWhere((c) => c['id'] == course['id']);
    if (idx >= 0) {
        all[idx] = course;
        _writeAll(all);
    }
    }

    void enrollUser(String courseId, String userId) {
    final all = _readAll();
    final idx = all.indexWhere((c) => c['id'] == courseId);
    if (idx == -1) return;
    final enrolled = List<String>.from(all[idx]['enrolledUserIds'] ?? []);
    if (!enrolled.contains(userId)) {
        enrolled.add(userId);
        all[idx]['enrolledUserIds'] = enrolled;
        _writeAll(all);
    }
    }

    Map<String, dynamic>? getByCode(String code) {
    final all = _readAll();
    try {
        return all.firstWhere((c) => (c['code'] ?? '') == code);
    } catch (_) {
        return null;
    }
    }
}
