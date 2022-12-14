part of be_universe_core;

@RestApi()
abstract class JourneyApi {
  factory JourneyApi() => _JourneyApi(Api.client);

  @GET('journeys/query/filters')
  Future<List<JourneyResponse>> getPaginatedJourneys(
    @Query('type') String type,
    @Query('page') String page,
    @Query('limit') String limit,
  );
  @PATCH('journeys/update-progress')
  Future<void> sendJourneyProgress(
      @Body() JourneyProgressRequest progressRequest);

  @GET('journeys/progress/{id}')
  Future<JourneyProgressResponse> getJourneyProgress(@Path() String id);
}
