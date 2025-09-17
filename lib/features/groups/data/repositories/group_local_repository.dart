import 'package:get_storage/get_storage.dart';
import '../../../../core/storage/storage_service.dart';

class GroupLocalRepository {
  final GetStorage _db = StorageService.db();

  List<Map<String, dynamic>> _readAll() =>
      List<Map<String, dynamic>>.from(_db.read('groups') ?? []);
  void _writeAll(List<Map<String, dynamic>> data) => _db.write('groups', data);

  List<Map<String, dynamic>> listByCourse(String courseId) =>
      _readAll().where((g) => g['courseId'] == courseId).toList();

  List<Map<String, dynamic>> listByCategory(String categoryId) =>
      _readAll().where((g) => g['categoryId'] == categoryId).toList();

  void create(Map<String, dynamic> g) {
    final all = _readAll();
    all.add(g);
    _writeAll(all);
  }

  void update(Map<String, dynamic> g) {
    final all = _readAll();
    final idx = all.indexWhere((x) => x['id'] == g['id']);
    if (idx >= 0) {
      all[idx] = g;
      _writeAll(all);
    }
  }

  void delete(String id) {
    final all = _readAll()..removeWhere((x) => x['id'] == id);
    _writeAll(all);
  }
}
