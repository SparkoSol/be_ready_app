part of be_universe_core;

const _accessTokenKey = 'access_token';

class AppData with ProfileMixin {
  static late SharedPreferences _preferences;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    Hive.registerAdapter(ProfileResponseAdapter());
    await ProfileMixin.initialize();
  }

  static Future<void> saveAccessToken(String token) async {
    await _preferences.setString(_accessTokenKey, token);
  }

  static String get accessToken =>
      _preferences.getString(_accessTokenKey) ?? '';

  static String getAccessToken() {
    var token = _preferences.getString(_accessTokenKey);
    return token ?? '';
  }

  static Future<void> clearLocalData() async {
    await _preferences.clear();
    await ProfileMixin.clearUsers();
  }
}
