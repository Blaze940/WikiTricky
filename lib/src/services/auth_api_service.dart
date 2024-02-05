import 'package:dio/dio.dart';

import '../exceptions/auth_api_exception.dart';


class AuthApiService {
  final Dio _dio = Dio();
  final String baseAuthUrl = "https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi/auth";

  Future<void> signup(String email, String name, String password) async {
    try {
         await _dio.post(
        "$baseAuthUrl/signup",
        data: {
          'email': email,
          'name': name,
          'password': password,
        },
      );
    } on DioException {
      rethrow;
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
    } on DioException{
      rethrow ;
    }
  }

  Future<dynamic> getCurrentUserInfo(String bearerAuth) async {
    //TODO: Complete logic
  }
}
