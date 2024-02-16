class CommentUpdateRequest {
  final int comment_id;
  final String content;

  CommentUpdateRequest({
    required this.comment_id,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'comment_id': comment_id,
      'content': content,
    };
  }

}