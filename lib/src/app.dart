import 'package:flutter/material.dart';

import 'base/theme.dart';
import 'components/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Application',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
