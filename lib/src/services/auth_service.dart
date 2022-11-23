import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final _firebaseAuth = FirebaseAuth.instance;

  static bool get isSignIn => _firebaseAuth.currentUser != null;

  static User get currentUser => _firebaseAuth.currentUser!;

  Future<User> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw 'Login failed';
      }
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Email or password is incorrect.';
      }
      throw e.message ?? 'Internet connection error';
    } catch (_) {
      rethrow;
    }
  }

  Future<void> passwordChangeValidation(
    String newPassword,
    String oldPassword,
  ) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: currentUser.email!,
        password: oldPassword,
      );
      try {
        final check =
            await currentUser.reauthenticateWithCredential(credential);
        if (check.user != null) {
          await _firebaseAuth.currentUser!.updatePassword(newPassword);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          throw 'Old password did not match';
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
      throw e.message ?? 'Internet connection error';
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (r) {
      if (r.code == 'invalid-email') {
        throw 'Invalid Email Entered';
      } else if (r.code == 'user-not-found') {
        throw 'Account with this email not exists.';
      }
      throw r.message ?? 'Internet Connection error';
    } catch (e) {
      rethrow;
    }
  }

  Future<User> signUp(String email, String password) async {
    try {
      final createdUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (createdUser.user == null) {
        throw 'Login failed';
      }
      return createdUser.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
      throw e.message ?? 'Internet connection error';
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    try {
      final account = await GoogleSignIn().signIn();
      final authentication = await account!.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      return authResult;
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithFacebook() async {
    try {
      final account = await FacebookAuth.instance.login();
      final token = account.accessToken!.token;
      print(
          'Facebook token userID : ${account.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/'
          'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

      final profile = jsonDecode(graphResponse.body);
      print("Profile is equal to $profile");
      if (account.status != LoginStatus.success) {
        throw account.message ?? 'Facebook Login Failed';
      }
      final facebookAuthCredential =
          FacebookAuthProvider.credential(account.accessToken!.token);
      final authResult = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return authResult;
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signInWithApple() async {
    try {
      final appleCredentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredentials.identityToken,
        accessToken: appleCredentials.authorizationCode,
      );
      appleCredentials.identityToken;
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return authResult;
    } catch (e) {
      throw 'Apple authorization cancelled';
    }
  }
}
