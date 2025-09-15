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
                    "Método: ${c.groupingMethod.name} | Máx miembros: ${c.maxMembers}"),
                trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteCategory(c.id),
                ),
                onTap: () {
                // Editar categoría
                nameCtrl.text = c.name;
                membersCtrl.text = c.maxMembers.toString();

                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                    title: const Text("Editar categoría"),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        TextField(
                            controller: nameCtrl,
                            decoration:
                                const InputDecoration(labelText: "Nombre"),
                        ),
                        TextField(
                            controller: membersCtrl,
                            decoration:
                                const InputDecoration(labelText: "Máx miembros"),
                            keyboardType: TextInputType.number,
                        ),
                        ],
                    ),
                    actions: [
                        TextButton(
                        onPressed: () {
                            controller.updateCategory(
                            c.copyWith(
                                name: nameCtrl.text,
                                maxMembers: int.parse(membersCtrl.text),
                            ),
                            );
                            Navigator.pop(context);
                        },
                        child: const Text("Guardar"),
                        )
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
                    decoration:
                        const InputDecoration(labelText: "Máx miembros"),
                    keyboardType: TextInputType.number,
                    ),
                    DropdownButton<GroupingMethod>(
                    value: GroupingMethod.random,
                    onChanged: (value) {},
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
                        nameCtrl.text,
                        GroupingMethod.random,
                        int.tryParse(membersCtrl.text) ?? 1,
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
