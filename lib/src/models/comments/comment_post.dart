class CommentPost {
  final int post_id;
  final String content;

  CommentPost({
    required this.post_id,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'post_id': post_id,
      'content': content,
    };
  }
}
