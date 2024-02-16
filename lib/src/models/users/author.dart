class Author {
  final int id;
  final int created_at;
  final String name;

  Author({
    required this.id,
    required this.created_at,
    required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      created_at: json['created_at'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': created_at,
      'name': name,
    };
  }
}
