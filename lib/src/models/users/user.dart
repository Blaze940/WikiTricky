class User {
  final int id;
  final int created_at;
  String name;
  String? email;

  User({
    required this.id,
    required this.created_at,
    required this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      created_at: json['created_at'],
      name: json['name'],
      email: json['email'],
    );
  }



  //USELESS TO COPY , TOJSON BECAUSE NO ROUTES FOR PATCH

}