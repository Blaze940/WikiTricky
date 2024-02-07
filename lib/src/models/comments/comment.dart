import '../users/author.dart';

class Comment {
  final int id;
  final int createdAt;
  final String content;
  final Author author;

  Comment({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      author: Author.fromJson(json['author']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'content': content,
      'author': author.toJson(),
    };
  }
}
