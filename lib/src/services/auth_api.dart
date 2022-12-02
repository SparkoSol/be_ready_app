import 'dart:developer';

import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/home/home_page.dart';
import 'package:be_universe/src/services/auth_service.dart';
import 'package:be_universe/src/services/remember_me_service.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService {
  final _api = AuthenticationApi();

  Future<String> signIn(final UserSignInRequest request, bool rememberMe) async {
    try {
      final response = await _api.signIn(request);
      log(response.signInToken);
      await RememberMeService().setAccessToken(
        response.signInToken,
        rememberMe,
      );
      return response.signInToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(final UserRegisterRequest request) async {
    try {
      final profile = await _api.signUp(request);
      await signIn(
        UserSignInRequest(
          username: request.username,
          password: request.password,
        ),
        true,
      );
      await AppData().saveUser(profile);
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
      await AppData.clearLocalData();
      await _api.signingOut();
    } catch (_) {}
    try {
      await AuthService.signOut();
    } catch (_) {}
  }

  Future<void> signInWithFacebook(State state) async {
    try {
      final response = await AuthService.signInWithFacebook();
      if (response.user == null) {
        throw Exception('Login failed');
      }
      final token = await response.user!.getIdToken();
      await AuthenticationService().socialSignIn(
        SocialSignInRequest(
          username: response.user?.email ?? 'none',
          idToken: token,
          name: response.user?.displayName ?? 'default mail',
          email: response.user?.email ?? 'default mail',
          image: response.user?.photoURL ?? '',
          loginVia: 'Facebook',
        ),
      );
      if (!state.mounted) return;
      AppNavigation.navigateRemoveUntil(state.context, const HomePage());
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signInWithGoogle(State state) async {
    try {
      final response = await AuthService.signInWithGoogle();
      if (response.user == null) {
        throw Exception('Login failed');
      }
      final token = await response.user!.getIdToken();
      await AuthenticationService().socialSignIn(
        SocialSignInRequest(
          username: response.user?.email ?? 'none',
          idToken: token,
          name: response.user?.displayName ?? 'default mail',
          email: response.user?.email ?? 'default mail',
          image: response.user?.photoURL ?? '',
          loginVia: 'Google',
        ),
      );
      if (!state.mounted) return;
      AppNavigation.navigateRemoveUntil(state.context, const HomePage());
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signInWithApple(State state) async {
    try {
      final response = await AuthService.signInWithApple();
      final token = await response.user!.getIdToken();
      await AuthenticationService().socialSignIn(
        SocialSignInRequest(
          username: response.user?.email ?? 'none',
          idToken: token,
          name: response.user?.displayName ?? 'default mail',
          email: response.user?.email ?? 'default mail',
          image: response.user?.photoURL ?? '',
          loginVia: 'Apple',
        ),
      );
      if (!state.mounted) return;
      AppNavigation.navigateRemoveUntil(state.context, const HomePage());
    } catch (_) {
      rethrow;
    }
  }

  Future<void> socialSignIn(final SocialSignInRequest request) async {
    try {
      final socialResponse = await _api.socialSignIn(request);
      await RememberMeService().setAccessToken(
        socialResponse.socialToken,
        true,
      );
    } catch (_) {
      rethrow;
    }
  }
}
