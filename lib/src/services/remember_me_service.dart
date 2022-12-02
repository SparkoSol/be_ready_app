import 'package:be_universe_core/be_universe_core.dart';

class RememberMeService {
  factory RememberMeService() => _instance;

  RememberMeService._internal();

  static final _instance = RememberMeService._internal();

  String? _accessToken;
  bool _remember = true;

  String get accessToken {
    if (_remember) {
      return AppData.accessToken;
    }
    return _accessToken ?? '';
  }

  Future<void> setAccessToken(String token, bool rememberMe) async {
    _remember = rememberMe;
    // if (rememberMe) {
      await AppData.saveAccessToken(token);
    // } else {
      _accessToken = token;
    // }
  }
}
