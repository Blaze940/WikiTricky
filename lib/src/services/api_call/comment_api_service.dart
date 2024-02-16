import 'package:dio/dio.dart';

class CommentApiService {
  final Dio _dio = Dio();
  final String baseUrl =
      'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi/comment';

  Future<void> createComment(
      Map<String, dynamic> commentCreateRequest, String authToken) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
      await _dio.post(baseUrl, data: commentCreateRequest);
    } on DioException {
      rethrow;
    }
  }

  Future<void> updateComment(
      Map<String, dynamic> commentUpdateRequest, String authToken) async {
    final updateUrl = "$baseUrl/${commentUpdateRequest['comment_id']}";
    final dataToSend = {
      'content': commentUpdateRequest['content'],
    };
    try {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
      await _dio.patch(updateUrl, data: dataToSend);
    } on DioException {
      rethrow;
    }
  }

  Future<void> deleteComment(int comment_id, String authToken) async {
    final deleteUrl = "$baseUrl/$comment_id";
    try {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
      await _dio.delete(deleteUrl);
    } on DioException {
      rethrow;
    }
  }
}
