import '../images/user_item_image.dart';

class UserItem {
  final int id;
  final String createdAt;
  final String content;
  final int userId;
  final UserItemImage image;
  final int commentsCount;

  UserItem({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.userId,
    required this.image,
    required this.commentsCount,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      userId: json['user_id'],
      image: UserItemImage.fromJson(json['image']),
      commentsCount: json['comments_count'],
    );
  }
}
