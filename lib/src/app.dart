import 'package:be_ready_app/src/components/auth/sign_in_page.dart';
import 'package:be_ready_app/src/components/home/journey_page.dart';
import 'package:flutter/material.dart';

import 'base/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Be Ready',
      theme: AppTheme.lightTheme,
      home: const JourneyHomePage(),
    );
  }
}
