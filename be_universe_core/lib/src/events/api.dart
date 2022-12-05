part of be_universe_core;

@RestApi()
abstract class EventsApi {
  factory EventsApi() => _EventsApi(
        Api.client,
      );
  @POST('events')
  Future<EventsResponse> sendEvent(@Body() EventsResponse eventsResponse);

  @GET('events')
  Future<List<EventsResponse>> getAllEvents();
  @GET('banners')
  Future<List<BannerResponse>> getBanner();
}
