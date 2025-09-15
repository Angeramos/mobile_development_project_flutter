class AppUser {
    final String id;
    final String name;
    final String email;
    final String role; 

const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
});

AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
}) {
    return AppUser(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
    );
    }
}
