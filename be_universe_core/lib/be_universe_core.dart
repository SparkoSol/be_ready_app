library be_universe_core;

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authorization_interceptor.dart';

part 'be_universe_core.g.dart';

part 'data/app_data.dart';

part 'data/mixins/profile_mixin.dart';

part 'src/activities/api.dart';

part 'src/activities/models.dart';

part 'src/activities/requests.dart';

part 'src/activities/responses.dart';

part 'src/authentication/api.dart';

part 'src/authentication/models.dart';

part 'src/authentication/requests.dart';

part 'src/authentication/responses.dart';

part 'src/daily_check_in/api.dart';

part 'src/daily_check_in/models.dart';

part 'src/daily_check_in/requests.dart';

part 'src/daily_check_in/responses.dart';

part 'src/events/api.dart';

part 'src/events/models.dart';

part 'src/events/requests.dart';

part 'src/events/responses.dart';

part 'src/faq/api.dart';

part 'src/faq/models.dart';

part 'src/faq/requests.dart';

part 'src/faq/response.dart';

part 'src/journey/api.dart';

part 'src/journey/models.dart';

part 'src/journey/requests.dart';

part 'src/journey/responses.dart';

part 'src/profile/api.dart';

part 'src/profile/models.dart';

part 'src/profile/requests.dart';

part 'src/profile/responses.dart';

part 'src/resources/api.dart';

part 'src/resources/models.dart';

part 'src/resources/requests.dart';

part 'src/resources/responses.dart';

typedef Json = Map<String, dynamic>;

class Api {
  static const _apiUrl = 'https://api.be-universe.com/';
  // static const _apiUrl = 'http://192.168.18.45:3000/';

  static String get apiUl => _apiUrl;

  static Future<void> initialize() async {
    await AppData.initialize();
  }

  static final client = Dio(BaseOptions(baseUrl: _apiUrl))
    ..interceptors.add(AuthorizationInterceptor());
}

// extension ApiExtension on String {
//   String get fileUrl => '${Api.apiUl}uploads/$this';
//
//   String get videoFileUrl => '${Api.apiUl}get-file/$this';
// }
