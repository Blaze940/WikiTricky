class ApiError implements Exception{
  final int? code;
  final String? message;
  final String? payload;

  ApiError({this.code, required this.message, this.payload = ''});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'],
      message: json['message'],
      payload: json['payload'] ?? '',
    );
  }

  @override
  String toString() {
    if (payload!.isNotEmpty) {
      return '$message - $payload';
    }

    return message!;
  }
}
