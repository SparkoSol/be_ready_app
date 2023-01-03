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

  set isPending(bool value) {
    _isPending = value;
    notifyListeners();
    if (context != null) {
      if (!value) {
        $showSnackBar(context!, 'Purchase successful!');
        AppNavigation.navigateRemoveUntil(context!, const HomePage());
      }
    }
  }

  bool get isPending => _isPending;
}
