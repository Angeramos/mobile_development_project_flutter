import 'package:get_storage/get_storage.dart';
import '../../../../core/storage/storage_service.dart';

class CategoryLocalRepository {
    final GetStorage _db = StorageService.db();

    List<Map<String, dynamic>> _readAll() =>
        List<Map<String, dynamic>>.from(_db.read('categories') ?? []);
    void _writeAll(List<Map<String, dynamic>> data) => _db.write('categories', data);

    List<Map<String, dynamic>> listByCourse(String courseId) =>
        _readAll().where((c) => c['courseId'] == courseId).toList();

    void create(Map<String, dynamic> cat) {
    final all = _readAll(); all.add(cat); _writeAll(all);
    }

    void update(Map<String, dynamic> cat) {
    final all = _readAll();
    final idx = all.indexWhere((c) => c['id'] == cat['id']);
    if (idx >= 0) { all[idx] = cat; _writeAll(all); }
    }

    void delete(String id) {
    final all = _readAll()..removeWhere((c) => c['id'] == id);
    _writeAll(all);
    }
}
