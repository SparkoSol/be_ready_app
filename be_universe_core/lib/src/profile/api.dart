part of be_universe_core;

@RestApi()
abstract class ProfileApi {
  factory ProfileApi() => _ProfileApi(Api.client);

  @PATCH('persons/{id}')
  Future updateProfile(
    @Path() String id,
    @Body() ProfileUpdateRequest updateRequest,
  );
}
