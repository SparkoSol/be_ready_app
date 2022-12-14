import 'dart:io';

import 'package:be_universe/src/components/auth/sign_in_page.dart';
import 'package:be_universe/src/components/home/home_page.dart';
import 'package:be_universe/src/services/purchase_service.dart';
import 'package:be_universe/src/utils/default_awaiter.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

import 'base/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp._() : super();

  static Future<void> initializeAndRun() async {
    HttpOverrides.global = MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Awaiter.defaultBehaviour = AppAwaitBehaviour();
    await Api.initialize();

    /// Remember Me
    if (AppData.accessToken.isNotEmpty) {
      if (!AppData.rememberMe) {
        await AppData.clearLocalData();
      }
    }
    return runApp(const MyApp._());
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    PurchaseService.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Be Universe',
      theme: AppTheme.lightTheme,
      //  home: const DailyCheckInPage(),
      home: AppData.accessToken.isEmpty ? const SignInPage() : const HomePage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
