import 'dart:developer';

import 'package:be_universe/src/services/auth_service.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe_core/be_universe_core.dart';

class AuthenticationService {
  final _api = AuthenticationApi();

  Future<void> signIn(final UserSignInRequest request) async {
    try {
      final response = await _api.signIn(request);
      log(response.signintoken);
      await Api.saveAccessToken(response.signintoken);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(final UserRegisterRequest request) async {
    try {
      await _api.signUp(request);
    } catch (_) {
      rethrow;
    }
  }

  Future<ProfileResponse> getProfile(final String token) async {
    try {
      var profile = await _api.getProfile('Bearer $token');
      return profile;
    } catch (e) {
      throw DioException.withDioError(e).description;
    }
  }

  Future<void> signOut() async {
    try {
      await Api.clearLocalData();
      await _api.signingOut();
    } catch (_) {}
    try {
      await AuthService.signOut();
    } catch (_) {}
  }

  Future<void> socialSignIn(final SocialSignInRequest request) async {
    try {
      final socialResponse = await _api.socialSignIn(request);
      await Api.saveAccessToken(socialResponse.socialToken);
    } catch (e) {
      throw DioException.withDioError(e);
    }
  }
}
