enum GroupingMethod { random, selfAssigned }

class Category {
    final String id;
    final String courseId; 
    final String name;
    final GroupingMethod groupingMethod;
    final int maxMembers;

    Category({
    required this.id,
    required this.courseId,
    required this.name,
    required this.groupingMethod,
    required this.maxMembers,
    });

    Category copyWith({
    String? id,
    String? courseId,
    String? name,
    GroupingMethod? groupingMethod,
    int? maxMembers,
    }) {
    return Category(
        id: id ?? this.id,
        courseId: courseId ?? this.courseId,
        name: name ?? this.name,
        groupingMethod: groupingMethod ?? this.groupingMethod,
        maxMembers: maxMembers ?? this.maxMembers,
    );
    }

    Map<String, dynamic> toMap() {
    return {
        'id': id,
        'courseId': courseId,
        'name': name,
        'groupingMethod': groupingMethod.name,
        'maxMembers': maxMembers,
    };
    }

    factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map['id'],
        courseId: map['courseId'],
        name: map['name'],
        groupingMethod: GroupingMethod.values.firstWhere(
        (e) => e.name == map['groupingMethod'],
        orElse: () => GroupingMethod.random,
        ),
        maxMembers: map['maxMembers'],
    );
    }
}
