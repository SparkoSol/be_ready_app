part of be_universe_core;

@RestApi()
abstract class ProfileApi {
  factory ProfileApi() => _ProfileApi(Api.client);

  @GET('persons/{id}')
  Future<ProfileResponse> getProfile(
    @Path('id') String id,
  );

  @PATCH('persons/{id}')
  Future updateProfile(
    @Path() String id,
    @Body() ProfileUpdateRequest updateRequest,
  );

  @PATCH('persons/{id}/receipt')
  Future updateReceipt(
    @Path('id') String id,
    @Body() UpdateReceiptRequest request,
  );
}
