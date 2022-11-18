import 'package:flutter/material.dart';

class AuthTitleWidget extends StatelessWidget {
  const AuthTitleWidget({Key? key, required this.title, this.align})
      : super(key: key);

  final String title;
  final Alignment? align;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align ?? Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
