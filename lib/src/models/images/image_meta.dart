class ImageMeta {
  final int width;
  final int height;

  ImageMeta({
    required this.width,
    required this.height,
  });

  factory ImageMeta.fromJson(Map<String, dynamic> json) {
    return ImageMeta(
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
    };
  }
}
