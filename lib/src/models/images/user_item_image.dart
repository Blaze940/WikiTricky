class UserItemImage {
  final String access;
  final String path;
  final String name;
  final String type;
  final int size;
  final String mime;
  final Map<String, dynamic> meta;
  final String url;

  UserItemImage({
    required this.access,
    required this.path,
    required this.name,
    required this.type,
    required this.size,
    required this.mime,
    required this.meta,
    required this.url,
  });

  factory UserItemImage.fromJson(Map<String, dynamic> json) {
    return UserItemImage(
      access: json['access'],
      path: json['path'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      mime: json['mime'],
      meta: json['meta'] != null ? Map<String, dynamic>.from(json['meta']) : {},
      url: json['url'],
    );
  }
}
