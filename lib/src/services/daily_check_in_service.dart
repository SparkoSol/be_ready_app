import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:reusables/reusables.dart';

class DailyCheckInService {
  final _api = DailyCheckInApi();

  Future<DailyCheckInModel> sendDailyCheckInData(
    DailyCheckInModel dailyCheckInModel,
  ) async {
    try {
      final response = _api.sendDailyCheckIn(dailyCheckInModel);
      return response;
    } catch (e) {
      throw DioException.withDioError(e);
    }
  }

  Future<bool> getDailyCheckIn() async {
    try {
      final response = await Api.client.get(
          '${Api.apiUl}daily-check-in/user/${AppData().readLastUser().userid}/last');
      if (response.statusCode != 200) {
        throw 'Internet connection error';
      }
      if (response.data == null) {
        return true;
      }
      if (response.data == 'null') {
        return true;
      }
      final data = DailyCheckInResponse.fromJson(response.data);
      var dateTime = DateTime.parse(data.createdAt).dateFormat;
      var date = DateTime.parse(data.date).dateFormat;
      return date != dateTime;
    } catch (_) {
      rethrow;
    }
  }
}
