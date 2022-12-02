part of 'be_universe_core.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (AppData.accessToken.isNotEmpty) {
      options.headers["Authorization"] = "Bearer ${AppData.accessToken}";
    }
    return handler.next(options);
  }

// @override
// void onError(
//   DioError err,
//   ErrorInterceptorHandler handler,
// ) async {
//   if (err.response != null) {
//     if ((err.response?.statusCode ?? 0) == 401 ||
//         (err.response?.statusCode ?? 0) == 403) {
//       try {
//         // final _refresh = await IdentityApi().refreshToken(
//         //   RefreshTokenRequest(
//         //     refreshToken: _preferences.getString(_accessTokenKey) ?? '',
//         //   ),
//         // );
//         // await Api.saveAccessToken(
//         //   _refresh.accessToken,
//         //
//         // );
//         var _accessToken = _preferences.getString(_accessTokenKey) ?? '';
//         final requestOptions = err.response!.requestOptions;
//         requestOptions.headers['Authorization'] = 'Bearer $_accessToken';
//         final options = Options(
//           method: requestOptions.method,
//           headers: requestOptions.headers,
//         );
//         final dioRefresh = Dio(
//           BaseOptions(
//             baseUrl: requestOptions.baseUrl,
//             headers: <String, String>{
//               'accept': 'application/json',
//             },
//           ),
//         );
//         final response = await dioRefresh.request<dynamic>(
//           requestOptions.path,
//           data: requestOptions.data,
//           queryParameters: requestOptions.queryParameters,
//           options: options,
//         );
//         return handler.resolve(response);
//       } catch (_) {}
//     }
//   }
//   handler.next(err);
// }
}
