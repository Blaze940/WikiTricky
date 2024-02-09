import 'package:dio/dio.dart';

import '../../models/posts/post.dart';

class PostApiService {
  final Dio _dio = Dio();
  final String basePostUrl =
      "https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi/post";

  Future<Post> getFirstPostRecords() async {
    try {
      final response = await _dio.get("$basePostUrl");
      final post = response.data;
      return Post.fromJson(post);
    } on DioException {
      rethrow;
    }
  }

  Future<Post> getNextPagePostRecords(int page) async {
    try {
      //call get with param page to get next page
      final response = await _dio.get("$basePostUrl?page=$page");
      final post = response.data;
      return Post.fromJson(post);
    } on DioException {
      rethrow;
    }
  }

  Future<void> createPost(
      Map<String, dynamic> postCreateRequest, String authToken) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
      await _dio.post("$basePostUrl", data: postCreateRequest);
    } on DioException {
      rethrow;
    }
  }

  Future<void> updatePost(
      Map<String, dynamic> postUpdateRequest, String authToken) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
      await _dio.put("$basePostUrl",
          data: postUpdateRequest,
          queryParameters: {'post_id': postUpdateRequest['postId']});
    } on DioException {
      rethrow;
    }
  }

  Future<void> deletePost(int postId, String authToken) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
      await _dio.delete("$basePostUrl", queryParameters: {'post_id': postId});
    } on DioException {
      rethrow;
    }
  }
}
