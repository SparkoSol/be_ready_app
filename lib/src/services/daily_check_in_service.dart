import 'package:be_ready_app/src/services/exception_service.dart';
import 'package:be_universe_core/be_universe_core.dart';

class DailyCheckInService {
  final _api = DailyCheckInApi();

  Future<DailyCheckInResponse> getDailyCheckInData() async {
    try {
      final response = _api.getDailyCheckIn();
      print(await response);
      return response;
    } catch (e) {
      throw DialogError.withDioError(e);
    }
  }

  Future<DailyCheckInModel> sendDailyCheckInData(
      final DailyCheckInModel dailyCheckInModel) async {
    try {
      final response = _api.sendDailyCheckIn(dailyCheckInModel);
      return response;
    } catch (e) {
      throw DialogError.withDioError(e);
    }
  }
}
