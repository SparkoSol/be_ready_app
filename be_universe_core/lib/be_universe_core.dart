library be_universe_core;

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authorization_interceptor.dart';

part 'be_universe_core.g.dart';

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

part 'src/resources/api.dart';

part 'src/resources/models.dart';

part 'src/resources/requests.dart';

part 'src/resources/responses.dart';

part 'data/app_data.dart';

part 'data/mixins/profile_mixin.dart';

typedef _Json = Map<String, dynamic>;

class Api {
  static Future<void> initialize() async {
    await AppData.initialize();
  }

  static final client = Dio(BaseOptions(
    baseUrl: 'https://beuniverse-api.sparkosol.com/',
  ))
    ..interceptors.add(AuthorizationInterceptor());
}
