import '../images/image_data.dart';
import '../users/author.dart';

class Item {
  final int id;
  final int createdAt;
  final String content;
  final ImageData? image;
  final Author author;
  final int commentsCount;

  Item({
    required this.id,
    required this.createdAt,
    required this.content,
    this.image,
    required this.author,
    required this.commentsCount,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      image: json['image'] != null ? ImageData.fromJson(json['image']) : null,
      author: Author.fromJson(json['author']),
      commentsCount: json['comments_count'],
    );
  }
}
