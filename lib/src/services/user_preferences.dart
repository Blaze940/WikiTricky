import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> saveUserData(Map<String,dynamic> data ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', data['id']);
    prefs.setString('name', data['name']);
    prefs.setString('email', data['email']);
  }

  static Future<Map<String,dynamic>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getInt('id'),
      'name': prefs.getString('name'),
      'email': prefs.getString('email'),
    };
  }

  static Future<void> removeUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
  }
}
