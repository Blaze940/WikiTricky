class ApiError implements Exception{
  final int? code;
  final String? message;
  final Map<dynamic,dynamic>? payload;

  ApiError({this.code, required this.message, this.payload = const {}});

  @override
  String toString() {
    return message!;
  }
}
