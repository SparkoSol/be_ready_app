import 'package:flutter/cupertino.dart';

class SubConfig extends ChangeNotifier {
  SubConfig._();

  static final _instance = SubConfig._();

  static SubConfig get instance => _instance;

  var _isPending = false;

  set isPending(bool value) {
    _isPending = value;
    notifyListeners();
  }

  bool get isPending => _isPending;
}
