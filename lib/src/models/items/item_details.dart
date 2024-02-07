import '../comments/comment.dart';
import '../images/image_data.dart';
import '../users/author.dart';

class ItemDetails {
  final int id;
  final int createdAt;
  final String content;
  final ImageData? image;
  final Author author;
  final List<Comment> comments;

  ItemDetails({
    required this.id,
    required this.createdAt,
    required this.content,
    this.image,
    required this.author,
    required this.comments,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      image: json['image'] != null ? ImageData.fromJson(json['image']) : null,
      author: Author.fromJson(json['author']),
      comments: List<Comment>.from(json['comments'].map((x) => Comment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'content': content,
      'image': image?.toJson(),
      'author': author.toJson(),
      'comments': comments.map((x) => x.toJson()).toList(),
    };
  }
}
