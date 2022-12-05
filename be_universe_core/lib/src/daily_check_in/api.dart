part of be_universe_core;

@RestApi()
abstract class DailyCheckInApi {
  factory DailyCheckInApi() => _DailyCheckInApi(
        Api.client,
      );

  @POST('daily-check-in')
  Future<DailyCheckInModel> sendDailyCheckIn(
      @Body() DailyCheckInModel dailyCheckInModel);

  @GET('daily-check-in/{id}')
  Future<DailyCheckInResponse> getDailyCheckIn(
    @Path('id') String id,
  );
  //
  // @GET('daily-check-in/user/{id}/last')
  // Future<DailyCheckInResponse?> getLastDailyCheckIn(
  //   @Path('id') String id,
  // );
}
