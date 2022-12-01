import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:retrofit/http.dart';

class DailyCheckInService {
  final _api = DailyCheckInApi();

  // Future<DailyCheckInResponse> getDailyCheckInData(
  //     @Query('id') String id) async {
  //   try {
  //     final response = _api.getDailyCheckIn();
  //
  //     return response;
  //   } catch (e) {
  //     throw DioException.withDioError(e);
  //   }
  // }

  Future<DailyCheckInModel> sendDailyCheckInData(
      final DailyCheckInModel dailyCheckInModel) async {
    try {
      final response = _api.sendDailyCheckIn(dailyCheckInModel);
      return response;
    } catch (e) {
      throw DioException.withDioError(e);
    }
  }
}
