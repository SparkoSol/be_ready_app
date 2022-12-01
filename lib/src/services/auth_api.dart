import 'dart:developer';

import 'package:be_ready_app/src/utils/dio_exception.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      await _api.signingOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
    } catch (e) {
      throw DioException.withDioError(e);
    }
  }

  Future<void> socialSignIn(final SocialSignInRequest request) async {
    try {
      final socialResponse = await _api.socialSignIn(request);
      await Api.saveAccessToken(socialResponse.socialToken);
    } catch (e) {
      throw DioException.withDioError(e).description;
    }
  }
}
