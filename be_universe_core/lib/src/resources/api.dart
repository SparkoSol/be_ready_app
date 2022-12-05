part of be_universe_core;

@RestApi()
abstract class ResourcesApi {
  factory ResourcesApi() => _ResourcesApi(
        Api.client,
      );

  @GET('resources/query/filters')
  Future<List<ResourceResponse>> getPaginatedResource(
    @Query('page') String page,
    @Query('limit') String limit, {
    @Query('type') String? type,
    @Query('liked') String? liked,
    @Query('user_id') String? userId,
  });

  @GET('resources')
  Future<List<ResourceResponse>> getAllResources();

  @PATCH('resources/{id}')
  Future<void> likeResource(
      @Query('user_id') String userId, @Path('id') String rId);

  @GET('resources/count/all')
  Future<ResourceCountResponse> getResourcesCount();
}
