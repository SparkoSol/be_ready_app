import 'package:dio/dio.dart';

typedef ParseException = String Function(dynamic error);

class DioException implements Exception {
  static set setDefaultParser(ParseException parseException) {
    _parseException = parseException;
  }

  static ParseException? _parseException;

  String? _description;

  String get description => _description ?? '';

  DioException.withDioError(dynamic error) {
    if (_parseException != null) {
      _description = _parseException!(error);
      return;
    }
    _description = '';
    if (error is DioError) {
      if (error.response != null) {
        _description = error.response!.data?.toString() ?? '';
      } else if (error.message.contains('SocketException') ||
          error.message.contains('Connecting timed')) {
        _description = 'Internet Connection Error';
      } else {
        _description = error.message;
      }
    } else {
      _description = error.toString();
    }
  }
}
