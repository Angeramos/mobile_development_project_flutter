import 'package:get/get.dart';
import '../../domain/entities/category.dart';
import '../../data/repositories/category_local_repository.dart';

class CategoriesController extends GetxController {
    final RxList<Category> categories = <Category>[].obs;
    final _repo = CategoryLocalRepository();

    void loadByCourse(String courseId) {
    final raw = _repo.listByCourse(courseId);
    categories.assignAll(
        raw.map((m) => Category(
            id: m['id'],
            name: m['name'],
            groupingMethod: m['groupingMethod'] == 'random'
                ? GroupingMethod.random
                : GroupingMethod.selfAssigned,
            maxMembers: m['maxMembers'],
            courseId: m['courseId'], 
            )),
    );
    }


    void addCategory(
    String courseId,
    String name,
    GroupingMethod method,
    int maxMembers,
    ) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _repo.create({
        'id': id,
        'courseId': courseId,
        'name': name,
        'groupingMethod': method.name,
        'maxMembers': maxMembers,
    });
    loadByCourse(courseId);
    }

    void updateCategory(String courseId, Category updated) {
    _repo.update({
        'id': updated.id,
        'courseId': courseId,
        'name': updated.name,
        'groupingMethod': updated.groupingMethod.name,
        'maxMembers': updated.maxMembers,
    });
    loadByCourse(courseId);
    }

    void deleteCategory(String courseId, String id) {
    _repo.delete(id);
    loadByCourse(courseId);
    }
}
