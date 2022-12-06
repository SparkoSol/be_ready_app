part of be_universe_core;

@RestApi()
abstract class JourneyApi {
  factory JourneyApi() => _JourneyApi(Api.client);
}
