import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/controllers/categories_controller.dart';
import '../../presentation/controllers/groups_controller.dart';

class GroupsPage extends StatefulWidget {
  final String courseId;
  const GroupsPage({super.key, required this.courseId});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final cats = Get.find<CategoriesController>();
  final groups = Get.find<GroupsController>();

  @override
  void initState() {
    super.initState();
    cats.loadByCourse(widget.courseId);
    groups.loadByCourse(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grupos por categoría')),
      body: Obx(() {
        if (cats.categories.isEmpty) {
          return const Center(child: Text('No hay categorías'));
        }
        return ListView(
          children: [
            for (final cat in cats.categories) ...[
              ListTile(
                title: Text('Categoría: ${cat.name}'),
                subtitle: Text(
                  'Método: ${cat.groupingMethod.name} • Máx: ${cat.maxMembers}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.group_add),
                  tooltip: 'Crear grupo para esta categoría',
                  onPressed: () {
                    groups.createForCategory(
                      courseId: widget.courseId,
                      category: {
                        'id': cat.id,
                        'name': cat.name,
                        'groupingMethod': cat.groupingMethod.name,
                        'maxMembers': cat.maxMembers,
                        'courseId': widget.courseId,
                      },
                    );
                  },
                ),
              ),
              _CategoryGroupsList(category: cat, courseId: widget.courseId),
              const Divider(),
            ],
          ],
        );
      }),
    );
  }
}

class _CategoryGroupsList extends StatelessWidget {
  final Category category;
  final String courseId;
  const _CategoryGroupsList({required this.category, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final groupsCtrl = Get.find<GroupsController>();
    final auth = Get.find<AuthController>();

    return Obx(() {
      final catGroups = groupsCtrl.groups
          .where((g) => g['categoryId'] == category.id)
          .toList();
      if (catGroups.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('No hay grupos aún para esta categoría'),
        );
      }
      return Column(
        children: catGroups.map((g) {
          final members = List<String>.from(g['memberIds'] ?? []);
          return ListTile(
            leading: const Icon(Icons.group),
            title: Text(g['name'] ?? category.name),
            subtitle: Text(
              'Miembros: ${members.length}/${category.maxMembers}',
            ),
            trailing: ElevatedButton(
              onPressed: () {
                final ok = groupsCtrl.joinGroup(
                  groupId: g['id'],
                  userId: auth.user.value?.id ?? '',
                  maxMembers: category.maxMembers,
                );
                if (!ok) {
                  Get.snackbar('Grupo lleno', 'No hay cupos disponibles.');
                } else {
                  Get.snackbar(
                    '¡Te uniste!',
                    'Ahora perteneces al grupo ${g['name']}',
                  );
                }
              },
              child: const Text('Unirme'),
            ),
          );
        }).toList(),
      );
    });
  }
}
