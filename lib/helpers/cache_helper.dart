import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _preferences?.setString('token', token);
    print('Token saved: $token');
  }

  static String? getToken() {
    final token = _preferences?.getString('token');
    print('Retrieved token: $token');
    return token;
  }

  static Future<void> removeToken() async {
    await _preferences?.remove('token');
  }
}
