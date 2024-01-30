class ApiError {
  final String code;
  final String message;
  final String payload;

  ApiError({required this.code, required this.message, this.payload = ''});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'],
      message: json['message'],
      payload: json['payload'] ?? '',
    );
  }

  @override
  String toString() => 'Error: $code - $message';
}
