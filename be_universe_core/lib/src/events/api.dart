part of be_universe_core;

@RestApi()
abstract class EventsApi {
  factory EventsApi() => _EventsApi(
        Api.client,
        baseUrl: 'https://192.168.195.77:3002/',
      );
  @POST('events')
  Future<EventsResponse> sendEvent(@Body() EventsResponse eventsResponse);

  @GET('events')
  Future<List<EventsResponse>> getAllEvents();
}
