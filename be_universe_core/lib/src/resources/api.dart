part of be_universe_core;

@RestApi()
abstract class ResourcesApi {
  factory ResourcesApi() => _ResourcesApi(
        Api.client,
        baseUrl: 'https://192.168.11.193:3002/',
      );

  @GET('resources/query/filters')
  Future<List<ResourceResponse>> getResource(@Query('type') String type);

  @GET('resources')
  Future<List<ResourceResponse>> getAllResources();
}
