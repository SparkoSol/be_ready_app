import 'package:flutter/material.dart';

class DrawerActionTitleWidget extends StatelessWidget {
  const DrawerActionTitleWidget({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
