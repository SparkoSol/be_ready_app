part of be_universe_core;

@RestApi()
abstract class ResourcesApi {
  factory ResourcesApi() => _ResourcesApi(
        Api.client,
      );

  @GET('resources/query/filters')
  Future<List<ResourceResponse>> getPaginatedResource(
    @Query('type') String type,
    @Query('page') String page,
    @Query('limit') String limit,
  );

  @GET('resources')
  Future<List<ResourceResponse>> getAllResources();

  @GET('resources/count/all')
  Future<ResourceCountResponse> getResourcesCount();
}
