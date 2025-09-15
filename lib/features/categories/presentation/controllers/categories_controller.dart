import 'package:get/get.dart';
import '../../domain/entities/category.dart';

class CategoriesController extends GetxController {
    final RxList<Category> categories = <Category>[].obs;
    final RxnString error = RxnString();

    void addCategory(String name, GroupingMethod method, int maxMembers) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final category = Category(
        id: id,
        name: name,
        groupingMethod: method,
        maxMembers: maxMembers,
    );
    categories.add(category);
    }

    void updateCategory(Category updated) {
    final index = categories.indexWhere((c) => c.id == updated.id);
    if (index == -1) {
        error.value = "Categoría no encontrada";
        return;
    }
    categories[index] = updated;
    }

    void deleteCategory(String id) {
    categories.removeWhere((c) => c.id == id);
    }

    List<Category> listCategories() => categories.toList();
}
