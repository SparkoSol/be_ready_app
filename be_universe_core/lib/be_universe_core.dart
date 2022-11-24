library be_universe_core;

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'be_universe_core.g.dart';

part 'src/authentication/api.dart';

part 'src/authentication/models.dart';

part 'src/authentication/requests.dart';

part 'src/authentication/responses.dart';

late SharedPreferences _preferences;
const _accessTokenKey = 'access_token';
const _userId = 'user_id';
const _userName = 'user_name';
const _rememberMe = 'remember_me';

typedef _Json = Map<String, dynamic>;

class Api {
  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static final client = Dio(BaseOptions());

  static Future<void> saveAccessToken(String token) async {
    await _preferences.setString(_accessTokenKey, token);
  }

  static Future<void> saveProfileData(
    String id,
    String name,
  ) async {
    await _preferences.setString(_userName, name);
    await _preferences.setString(_userId, id);
  }

  static Future<void> saveRememberMe(bool status) async {
    await _preferences.setBool(_rememberMe, status);
  }

  static Future<bool> getRememberMeStatus() async {
    bool status = _preferences.getBool(_rememberMe)!;
    return status;
  }

  static Future<String> getAccessToken() async {
    var token = _preferences.getString(_accessTokenKey);
    return token ?? 'null';
  }

  static Future<Map<String, String>> getProfileDate() async {
    var name = _preferences.getString(_userName);
    var id = _preferences.getString(_userId);
    return {'userName': name!, 'userId': id!};
  }

  static Future<void> clearLocalData() async {
    await _preferences.clear();
  }
}
