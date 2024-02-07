import 'image_meta.dart';

class ImageData {
  final String path;
  final String name;
  final String type;
  final int size;
  final String mime;
  final ImageMeta meta;
  final String url;

  ImageData({
    required this.path,
    required this.name,
    required this.type,
    required this.size,
    required this.mime,
    required this.meta,
    required this.url,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      path: json['path'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      mime: json['mime'],
      meta: ImageMeta.fromJson(json['meta']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'name': name,
      'type': type,
      'size': size,
      'mime': mime,
      'meta': meta.toJson(),
      'url': url,
    };
  }
}
