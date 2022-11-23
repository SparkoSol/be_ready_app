import 'package:dio/dio.dart';

class DialogError implements Exception {
  late String title;
  late String description;

  DialogError({required this.description, required this.title});

  DialogError.withDioError(error) {
    title = 'Error';
    description = '';
    if (error is DioError) {
      if ((error.response?.statusCode ?? 0) == 400) {
        if (error.response?.data != null) {
          var response = error.response!.data;
          if (response is String) {
            description = response;
          } else if (response['error_description']?.toString().isNotEmpty ??
              false) {
            if (response['error_description'] ==
                'invalid_username_or_password') {
              description = 'Invalid UserName or Password';
            } else {
              description = response['error_description'];
            }
          } else if ((response['errors']?.toString().isNotEmpty ?? false) &&
              response['errors'].first['code'] == 'PasswordMismatch') {
            description = 'Incorrect password, old password did not match';
          } else if (response['DuplicateUserName']?.isNotEmpty ?? false) {
            description = response['DuplicateUserName'][0];
          } else {
            description = 'Internet Connection Error';
          }
        }
      } else if ((error.response?.statusCode ?? 0) == 401) {
        description = 'email or password incorrect';
      } else if (error.message.contains('SocketException') ||
          error.message.contains('Connecting timed')) {
        description = 'Internet Connection Error';
      } else {
        description = error.message;
      }
    } else {
      description = error.message.toString();
    }
  }
}
