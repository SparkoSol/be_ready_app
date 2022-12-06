import 'package:be_universe/src/components/journey/be_universe_view.dart';

class AppUtils {
  static String getTherapy({required TherapyType therapy}) {
    switch (therapy) {
      case TherapyType.mind:
        return 'Mind';
      case TherapyType.body:
        return 'Body';
      case TherapyType.spirit:
        return 'Spirit';
    }
  }
}
