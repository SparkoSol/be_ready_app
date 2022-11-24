part of be_universe_core;

@RestApi()
abstract class DailyCheckInApi {
  factory DailyCheckInApi() => _DailyCheckInApi(
        Api.client,
        baseUrl: 'https://192.168.195.77:3002/',
      );
  @POST('daily-check-in')
  Future<DailyCheckInModel> sendDailyCheckIn(
      @Body() DailyCheckInModel dailyCheckInModel);

  @GET('daily-check-in')
  Future<DailyCheckInModel> getDailyCheckIn();
}
