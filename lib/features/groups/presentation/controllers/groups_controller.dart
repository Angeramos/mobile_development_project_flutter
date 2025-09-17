import 'package:get/get.dart';
import '../../../../core/storage/storage_service.dart';

class GroupsController extends GetxController {
    final groups = <Map<String, dynamic>>[].obs;

    void loadByCourse(String courseId) {
    final db = StorageService.db();
    final raw = List<Map<String, dynamic>>.from(db.read('groups') ?? []);
    groups.assignAll(raw.where((g) => g['courseId'] == courseId));
    }

    void createForCategory({
    required String courseId,
    required Map<String, dynamic> category,
    }) {
    final db = StorageService.db();
    final newGroup = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'courseId': courseId,
        'categoryId': category['id'],
        'name': category['name'],
        'memberIds': [],
    };
    final all = List<Map<String, dynamic>>.from(db.read('groups') ?? []);
    all.add(newGroup);
    db.write('groups', all);
    loadByCourse(courseId);
    }

    bool joinGroup({
    required String groupId,
    required int maxMembers,
    required String userId,
    }) {
    final db = StorageService.db();
    final all = List<Map<String, dynamic>>.from(db.read('groups') ?? []);
    final index = all.indexWhere((g) => g['id'] == groupId);

    if (index == -1) return false;

    final group = all[index];
    final members = List<String>.from(group['memberIds'] ?? []);

    if (members.contains(userId)) return true; // ya está inscrito
    if (members.length >= maxMembers) return false; // lleno

    members.add(userId);
    all[index] = {
        ...group,
        'memberIds': members,
    };

    db.write('groups', all);
    loadByCourse(group['courseId']);
    return true;
    }
}
