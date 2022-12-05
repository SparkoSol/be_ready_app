// import 'package:be_universe/src/utils/dio_exception.dart';
// import 'package:be_universe_core/be_universe_core.dart';
// import 'package:flutter/cupertino.dart';
//
// class EventsController extends ChangeNotifier {
//   late List<EventsResponse> events;
//   bool loading = true;
//   final api = EventsApi();
//
//   EventsController() {
//     initialization();
//   }
//
//   Future<void> initialization() async {
//     print('initialization');
//     loading = true;
//     events = await getEvents();
//     loading = false;
//     notifyListeners();
//   }
//
//   Future<List<EventsResponse>> getEvents() async {
//     try {
//       final response = await api.getAllEvents();
//
//       return response;
//     } catch (e) {
//       throw DioException.withDioError(e);
//     }
//   }
// }
