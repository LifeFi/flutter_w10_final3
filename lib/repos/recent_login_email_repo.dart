import 'package:shared_preferences/shared_preferences.dart';

class RecentLoginEmailRepository {
  static const String _recentLoginEmail = "_recentLoginEmail";

  final SharedPreferences _preferences;

  RecentLoginEmailRepository(this._preferences);

  Future<void> setRecentEmail(String email) async {
    //enum 을 index로 다루는 방법
    await _preferences.setString(_recentLoginEmail, email);
  }

  String getRecentEmail() {
    return _preferences.getString(_recentLoginEmail) ?? "";
  }
}
