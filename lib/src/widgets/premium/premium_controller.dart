import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/cupertino.dart';

class PremiumController extends ChangeNotifier {
  PremiumController._();

  static final instance = PremiumController._();

  var _isPremium = false;

  bool get isPremiumUser => _isPremium;

  void fetchUser() async {
    try {
      var profile =
          await ProfileApi().getProfile(AppData().readLastUser().userid);
      _isPremium = profile.isPremium ?? false;
      notifyListeners();
    } catch (_) {}
  }
}
