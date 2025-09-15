enum GroupingMethod { random, selfAssigned }

class Category {
    final String id;
    final String name;
    final GroupingMethod groupingMethod;
    final int maxMembers;

    Category({
    required this.id,
    required this.name,
    required this.groupingMethod,
    required this.maxMembers,
    });

    Category copyWith({
    String? id,
    String? name,
    GroupingMethod? groupingMethod,
    int? maxMembers,
    }) {
    return Category(
        id: id ?? this.id,
        name: name ?? this.name,
        groupingMethod: groupingMethod ?? this.groupingMethod,
        maxMembers: maxMembers ?? this.maxMembers,
    );
    }
}
