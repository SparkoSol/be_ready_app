import 'package:flutter/material.dart';

class AuthButtonTitleWidget extends StatelessWidget {
  const AuthButtonTitleWidget({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
       Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      Positioned(
        right: 16,
        bottom: -3.3,
        child: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFDA8B6D),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.0),
              ],
            ),
          ),
          child: const Icon(Icons.arrow_forward_sharp),
        ),
      ),
    ]);
  }
}
