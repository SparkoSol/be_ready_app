import 'package:be_ready_app/src/services/exception_service.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/cupertino.dart';

class EventsController extends ChangeNotifier {
  late List<EventsResponse> events;
  bool loading = true;

  EventsController() {
    initialization();
  }

  Future<void> initialization() async {
    print('initialization');
    loading = true;
    events = await getEvents();
    loading = false;
    notifyListeners();
  }

  Future<List<EventsResponse>> getEvents() async {
    print('getting events');
    try {
      final api = EventsApi();
      final response = await api.getAllEvents();
      print(response);
      return response;
    } catch (e) {
      throw DialogError.withDioError(e).description;
    }
  }
}
