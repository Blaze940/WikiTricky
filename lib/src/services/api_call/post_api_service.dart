import 'package:dio/dio.dart';
import 'package:wiki_tricky/src/models/items/item_details.dart';

import '../../models/posts/post.dart';

class PostApiService {
  final Dio _dio = Dio();
  final String basePostUrl =
      "https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi/post";

  Future<Post> getFirstPostRecords() async {
    try {
      final response = await _dio.get(basePostUrl);
      final post = response.data;
      return Post.fromJson(post);
    } on DioException {
      rethrow;
    }
  }

  Future<Post> getNextPagePostRecords(int page) async {
    try {
      final response = await _dio.get("$basePostUrl?page=$page");
      final post = response.data;
      return Post.fromJson(post);
    } on DioException {
      rethrow;
    }
  }

  Future<ItemDetails> getPostDetails(int post_id) async {
    try {
      final response = await _dio.get("$basePostUrl/$post_id");
      final postDetails = response.data;
      return ItemDetails.fromJson(postDetails);
    } on DioException {
      rethrow;
    }
  }

  Future<void> createPost(
      Map<String, dynamic> postCreateRequest, String authToken) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
      await _dio.post(basePostUrl, data: postCreateRequest);
    } on DioException {
      rethrow;
    }
  }

  Future<void> updatePost(
      Map<String, dynamic> postUpdateRequest, String authToken) async {
    final updateUrl = "$basePostUrl/${postUpdateRequest['post_id']}";
    final dataToSend = {
      'content': postUpdateRequest['content'],
      if (postUpdateRequest.containsKey('base_64_image')) 'base_64_image': postUpdateRequest['base_64_image'],
    };
    try {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
      await _dio.patch(updateUrl, data: dataToSend);
    } on DioException {
      rethrow;
    }
  }

  Future<void> deletePost(int postId, String authToken) async {
    final deleteUrl = "$basePostUrl/$postId";
    try {
      _dio.options.headers['Authorization'] = 'Bearer $authToken';
      await _dio.delete(deleteUrl);
    } on DioException {
      rethrow;
    }
  }
}
