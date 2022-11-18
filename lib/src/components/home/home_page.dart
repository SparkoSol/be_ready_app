import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButtonWidget(
          title: 'This is',
          onPressed: () {},
        ),
      ),
    );
  }
}
