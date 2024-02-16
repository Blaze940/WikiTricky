class CommentUpdate {
  final String comment_id;
  final String content;

  CommentUpdate({
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