import 'package:flutter/cupertino.dart';

class PremiumController extends ChangeNotifier {
  PremiumController._();

  static final instance = PremiumController._();

  var _isPremium = false;

  void fetchUser() async {}
}
