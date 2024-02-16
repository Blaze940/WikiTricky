class CommentCreateRequest {
  final int post_id;
  final String content;

  CommentCreateRequest({
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
