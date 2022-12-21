part of be_universe_core;

@RestApi()
abstract class FaqApi {
  factory FaqApi() => _FaqApi(
        Api.client,
      );

  @GET('faqs')
  Future<List<FaqResponse>> getFaqs();

  @POST('contact-us')
  Future<void> sendMessage(@Body() ContactUsRequest request);

  @POST('save-file')
  Future<SaveFileResponse> saveFile(@Part() File file);

  @GET('policies')
  Future<List<PoliciesResponse>> getPolicies();
}
