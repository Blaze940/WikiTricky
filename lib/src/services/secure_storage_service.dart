import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: 'authToken', value: token);
  }

  Future<String?> getAuthToken() async {
    try {
      return await _storage.read(key: 'authToken');
    } catch (e) {
      //print("error getAuthToken: " + e.toString());
      throw Exception('Failed to get auth token - ' + e.toString());
    }
  }

  Future<void> deleteAuthToken() async {
    try{
      await _storage.delete(key: 'authToken');
    } catch (e) {
      //print("error deleteAuthToken: " + e.toString());
      throw Exception('Failed to delete auth token - ' + e.toString());
    }
  }
}
