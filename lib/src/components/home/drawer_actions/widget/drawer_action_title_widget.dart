import 'package:flutter/material.dart';

class DrawerActionTitleWidget extends StatelessWidget {
  const DrawerActionTitleWidget({
    Key? key,
    required this.title,
    this.bottomPadding,
  }) : super(key: key);

  final String title;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: bottomPadding ?? 35),
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
