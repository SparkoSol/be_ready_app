import 'dart:developer';

import 'package:be_ready_app/src/services/exception_service.dart';
import 'package:be_universe_core/be_universe_core.dart';

class AuthenticationService {
  final _api = AuthenticationApi();

  Future<void> signIn(final UserSignInRequest request) async {
    try {
      final response = await _api.signIn(request);
      log(response.signintoken);
      await Api.saveAccessToken(response.signintoken);
    } catch (e) {
      throw DialogError.withDioError(e);
    }
  }

  Future<void> signUp(final UserRegisterRequest request) async {
    try {
      await _api.signUp(request);
    } catch (e) {
      throw DialogError.withDioError(e);
    }
  }

  Future<ProfileResponse> getProfile(final String token) async {
    try {
      var profile = await _api.getProfile(token);
      return profile;
    } catch (e) {
      throw DialogError.withDioError(e).description;
    }
  }

  Future<void> socialSignIn(final SocialSignInRequest request) async {
    try {
      final socialResponse = _api.socialSignIn(request);
      await Api.saveAccessToken(socialResponse.toString());
    } catch (e) {
      throw DialogError.withDioError(e).description;
    }
  }
}
