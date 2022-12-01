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
      if ((error.response?.statusCode ?? 0) == 400) {
        if (error.response?.data != null) {
          var response = error.response!.data;
          if (response is String) {
            _description = response;
          } else if (response['error_description']?.toString().isNotEmpty ??
              false) {
            if (response['error_description'] ==
                'invalid_username_or_password') {
              _description = 'Invalid UserName or Password';
            } else {
              _description = response['error_description'];
            }
          } else if ((response['errors']?.toString().isNotEmpty ?? false) &&
              response['errors'].first['code'] == 'PasswordMismatch') {
            _description = 'Incorrect password, old password did not match';
          } else if (response['DuplicateUserName']?.isNotEmpty ?? false) {
            _description = response['DuplicateUserName'][0];
          } else {
            _description = 'Internet Connection Error';
          }
        }
      } else if ((error.response?.statusCode ?? 0) == 401) {
        _description = 'email or password incorrect';
      } else if ((error.response?.statusCode ?? 0) == 406) {
        _description = 'Account with this email already exists.';
      }
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
