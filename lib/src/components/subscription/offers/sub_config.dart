import 'package:be_universe/src/base/modals/app_snackbar.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/home/home_page.dart';
import 'package:flutter/cupertino.dart';

class SubConfig extends ChangeNotifier {
  SubConfig._();

  static final _instance = SubConfig._();

  static SubConfig get instance => _instance;

  BuildContext? context;

  void bindContext(BuildContext context) => this.context ??= context;

  var _isPending = false;
  var _isFailed = false;

  void reset() {
    _isFailed = false;
    _isPending = false;
  }

  set isFailed(bool value) => _isFailed = true;

  set isPending(bool value) {
    print('RRRRRRRRR');
    print('Is Pending: $_isPending');
    print('Is Failed: $_isFailed');
    _isPending = value;
    notifyListeners();
    if (context != null) {
      if (!value) {
        if (_isFailed) {
          _isFailed = false;
          try {
            $showSnackBar(context!, 'Purchased failed');
          } catch (_) {}
          return;
        }
        try {
          $showSnackBar(context!, 'Purchased successful!');
        } catch (_) {}
        try {
          AppNavigation.navigateRemoveUntil(context!, const HomePage());
        } catch (_) {
          print('EEEEEERRRRROOORRRR');
          print(_);
        }
      }
    }
  }

  bool get isPending => _isPending;
}
