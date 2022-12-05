part of be_universe_core;

@RestApi()
abstract class FaqApi {
  factory FaqApi() => _FaqApi(
        Api.client,
      );

  @GET('faqs')
  Future<List<FaqResponse>> getAllFaqs();
}
