class Course {
    final String id;
    final String name;
    final String professorName;
    final List<String> enrolledUserIds;

    Course({
    required this.id,
    required this.name,
    required this.professorName,
    List<String>? enrolledUserIds,
    }) : enrolledUserIds = enrolledUserIds ?? [];

    Course copyWith({
    String? id,
    String? name,
    String? professorName,
    List<String>? enrolledUserIds,
    }) {
    return Course(
        id: id ?? this.id,
        name: name ?? this.name,
        professorName: professorName ?? this.professorName,
        enrolledUserIds: enrolledUserIds ?? List.from(this.enrolledUserIds),
    );
    }
}
