import 'package:dio/dio.dart';

class AuthApiService {
  final Dio _dio = Dio();
  final String baseAuthUrl = "https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi/auth";

  Future<dynamic> signup(String email, String name, String password) async {
    try {
      var response = await _dio.post(
        "$baseAuthUrl/signup",
        data: {
          'email': email,
          'name': name,
          'password': password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      var response = await _dio.post(
        "$baseAuthUrl/login",
        data: {
          'email': email,
          'password': password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception('Failed to login: ${e.message}');
    }
  }

  Future<dynamic> getCurrentUserInfo(String bearerAuth) async {
    //TODO: Complete logic in it
  }
}
