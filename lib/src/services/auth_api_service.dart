import 'package:dio/dio.dart';

class AuthApiService {
  final Dio _dio = Dio();
  final String baseAuthUrl = "https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi/auth";

  Future<dynamic> signup(String email, String name, String password) async {
    try {
      final token = await _dio.post(
        "$baseAuthUrl/signup",
        data: {
          'email': email,
          'name': name,
          'password': password,
        },
      );
      print("token signup: " + token.toString());
      return token.data;
    } on DioException catch (e) {
      print("error signup: " + e.toString());
      throw Exception('Failed to sign up: ${e.message}');
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      final token = await _dio.post(
        "$baseAuthUrl/login",
        data: {
          'email': email,
          'password': password,
        },
      );
      print("token login: " + token.toString());
      //print("Test login token: " + token.data['authToken']);
      return token.data;
    } on DioException catch (e) {
      print("error login: " + e.toString());
      throw Exception('Failed to login: ${e.message}');
    }
  }

  Future<dynamic> getCurrentUserInfo(String bearerAuth) async {
    //TODO: Complete logic in it
  }
}
