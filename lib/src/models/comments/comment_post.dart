class CommentPost {
  final int postId;
  final String content;

  CommentPost({
    required this.postId,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'content': content,
    };
  }
}
