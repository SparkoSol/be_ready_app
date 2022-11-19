import 'package:be_ready_app/src/components/goals/activites_page.dart';
import 'package:be_ready_app/src/components/home/home_page.dart';
import 'package:be_ready_app/src/components/main_menu/be_connected.dart';
import 'package:be_ready_app/src/components/main_menu/daily_check_in_page.dart';
import 'package:be_ready_app/src/components/goals/explore.dart';
import 'package:be_ready_app/src/components/main_menu/events.dart';
import 'package:flutter/material.dart';

import 'base/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Be Ready',
      theme: AppTheme.lightTheme,
      home:  HomePage(),
    );
  }
}
