import 'package:dio/dio.dart';

import '../exceptions/auth_api_exception.dart';


class AuthApiService {
  final Dio _dio = Dio();
  final String baseAuthUrl = "https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi/auth";

  Future<String> signup(String email, String name, String password) async {
    try {
      final response = await _dio.post(
        "$baseAuthUrl/signup",
        data: {
          'email': email,
          'name': name,
          'password': password,
        },
      );
      //Jusqu'ici tout va bien
      //print('responseData =' + response.data);
      //final authResponse = AuthResponse.fromJson(response.data);
      //print('authResponse =' + authResponse.toString());
      return response.data['authToken'] ;
      //return authResponse;
    } on DioException catch (e) {
      throw AuthApiException(
        code: e.response?.statusCode ?? 500,
        message: e.response?.statusMessage ?? 'Unknown error',
        payload: e.response?.data['payload'] ?? '',
      );
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "$baseAuthUrl/login",
        data: {
          'email': email,
          'password': password,
        },
      );
      return response.data['authToken'] ;
    } on DioException catch (e) {
      throw AuthApiException(
        code: e.response?.statusCode ?? 500,
        message: e.response?.statusMessage ?? 'Unknown error',
        payload: e.response?.data['payload'] ?? '',
      );
    }
  }

  Future<dynamic> getCurrentUserInfo(String bearerAuth) async {
    //TODO: Complete logic
  }
}
