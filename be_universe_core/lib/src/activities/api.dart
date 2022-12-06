part of be_universe_core;

@RestApi()
abstract class ActivitiesApi {
  factory ActivitiesApi() => _ActivitiesApi(
        Api.client,
      );

  @GET('activities')
  Future<List<ActivitiesResponse>> getPaginatedActivities(
      @Query('page') String page, @Query('limit') String limit);
}
