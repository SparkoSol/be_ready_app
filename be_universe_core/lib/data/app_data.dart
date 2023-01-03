part of be_universe_core;

class AppData with ProfileMixin {
  static late SharedPreferences _preferences;

  static const _accessTokenKey = 'access_token';
  static const _rememberKey = 'remember_me';

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    await Hive.initFlutter();
    Hive.registerAdapter(ProfileResponseAdapter());
    Hive.registerAdapter(PurchaseModelAdapter());
    Hive.registerAdapter(LatestReceiptInfoAdapter());
    await ProfileMixin.initialize();
  }

  static Future<void> saveAccessToken(String token) async {
    await _preferences.setString(_accessTokenKey, token);
  }

  static bool get isPremium => AppData().readLastUser().isPremium ?? false;

  static String get accessToken =>
      _preferences.getString(_accessTokenKey) ?? '';

  static Future<void> saveRememberMe(bool value) async {
    await _preferences.setBool(_rememberKey, value);
  }

  static bool get rememberMe => _preferences.getBool(_rememberKey) ?? true;

  static Future<void> clearLocalData() async {
    await _preferences.clear();
    await ProfileMixin.clearUsers();
  }
}
