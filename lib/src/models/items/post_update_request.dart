class PostUpdateRequest {
  final int post_id;
  final String content;
  final String? base_64_image;

  PostUpdateRequest({
    required this.post_id,
    required this.content,
    this.base_64_image,
  });

  Map<String, dynamic> toJson() {
    return {
      'post_id': post_id,
      'content': content,
      if (base_64_image != null) 'base_64_image': base_64_image,
    };
  }
}
