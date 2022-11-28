part of be_universe_core;

@RestApi()
abstract class ResourcesApi {
  factory ResourcesApi() => _ResourcesApi(
        Api.client,
        baseUrl: 'https://192.168.11.193:3002/',
      );

  @GET('resources/query/filters')
  Future<List<PaginatedResource>> getPaginatedResource(
      @Query('type') String type,
      @Query('page') String page,
      @Query('limit') String limit);

  @GET('resources')
  Future<List<ResourceResponse>> getAllResources();

  @GET('resources/count/all')
  Future<ResourceCountResponse> getResourcesCount();
}
