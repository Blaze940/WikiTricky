class User {
  String id;
  String created_at;
  String name;
  String email;

  User({
    required this.id,
    required this.created_at,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      created_at: json['created_at'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = created_at;
    data['name'] = name;
    data['email'] = email;
    return data;
  }

}