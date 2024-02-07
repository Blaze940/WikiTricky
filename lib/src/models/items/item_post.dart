class PostCreateRequest {
  final String content;
  final String? base_64_image;

  PostCreateRequest({
    required this.content,
     this.base_64_image,

  });

   Map<String, dynamic> toJson() {
    return {
      'content': content,
      if (base_64_image != null) 'base64Image': base_64_image,
    };
  }
}
