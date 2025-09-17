import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/categories_controller.dart';
import '../../domain/entities/category.dart';

class CategoriesPage extends StatelessWidget {
    const CategoriesPage({super.key});

    @override
    Widget build(BuildContext context) {
    final controller = Get.find<CategoriesController>();

    final nameCtrl = TextEditingController();
    final membersCtrl = TextEditingController();
    GroupingMethod selectedMethod = GroupingMethod.random;

    return Scaffold(
        appBar: AppBar(title: const Text("Categorías")),
        body: Obx(() {
        if (controller.categories.isEmpty) {
            return const Center(child: Text("No hay categorías creadas"));
        }
        return ListView.builder(
            itemCount: controller.categories.length,
            itemBuilder: (_, i) {
            final c = controller.categories[i];
            return ListTile(
                title: Text(c.name),
                subtitle: Text(
                "Método: ${c.groupingMethod.name} | Máx miembros: ${c.maxMembers}",
                ),
                trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteCategory(c.courseId, c.id),
                ),
                onTap: () {
                nameCtrl.text = c.name;
                membersCtrl.text = c.maxMembers.toString();
                selectedMethod = c.groupingMethod;

                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                    title: const Text("Editar categoría"),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        TextField(
                            controller: nameCtrl,
                            decoration: const InputDecoration(labelText: "Nombre"),
                        ),
                        TextField(
                            controller: membersCtrl,
                            decoration: const InputDecoration(labelText: "Máx miembros"),
                            keyboardType: TextInputType.number,
                        ),
                        DropdownButton<GroupingMethod>(
                            value: selectedMethod,
                            onChanged: (value) {
                            if (value != null) selectedMethod = value;
                            },
                            items: GroupingMethod.values
                                .map((m) => DropdownMenuItem(
                                    value: m,
                                    child: Text(m.name),
                                    ))
                                .toList(),
                        ),
                        ],
                    ),
                    actions: [
                        TextButton(
                        onPressed: () {
                            controller.updateCategory(
                            c.courseId,
                            Category(
                                id: c.id,
                                courseId: c.courseId,
                                name: nameCtrl.text,
                                groupingMethod: selectedMethod,
                                maxMembers: int.tryParse(membersCtrl.text) ?? c.maxMembers,
                            ),
                            );
                            Navigator.pop(context);
                        },
                        child: const Text("Guardar"),
                        ),
                    ],
                    ),
                );
                },
            );
            },
        );
        }),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
            nameCtrl.clear();
            membersCtrl.clear();
            selectedMethod = GroupingMethod.random;

            showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: const Text("Nueva categoría"),
                content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: "Nombre"),
                    ),
                    TextField(
                    controller: membersCtrl,
                    decoration: const InputDecoration(labelText: "Máx miembros"),
                    keyboardType: TextInputType.number,
                    ),
                    DropdownButton<GroupingMethod>(
                    value: selectedMethod,
                    onChanged: (value) {
                        if (value != null) selectedMethod = value;
                    },
                    items: GroupingMethod.values
                        .map((m) => DropdownMenuItem(
                                value: m,
                                child: Text(m.name),
                            ))
                        .toList(),
                    ),
                ],
                ),
                actions: [
                TextButton(
                    onPressed: () {
                    controller.addCategory(
                        "c_1",
                        nameCtrl.text,
                        selectedMethod,
                        int.tryParse(membersCtrl.text) ?? 0,
                    );
                    Navigator.pop(context);
                    },
                    child: const Text("Guardar"),
                )
                ],
            ),
            );
        },
        child: const Icon(Icons.add),
        ),
    );
    }
}
