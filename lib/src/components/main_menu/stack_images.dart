import 'package:be_ready_app/src/base/assets.dart';
import 'package:flutter/material.dart';

class StackImages extends StatelessWidget {
  const StackImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageStack(50, AppAssets.userIcon),
        imageStack(37.5, AppAssets.graphIcon),
        imageStack(25, AppAssets.graphIcon),
        imageStack(12.5, AppAssets.user),
        imageStack(0, AppAssets.graphIcon),
      ],
    );
  }

  Widget imageStack(double left, String url) {
    return Padding(
        padding: EdgeInsets.only(
          left: left,
        ),
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(url),
              fit: BoxFit.cover,
            ),
            color: const Color(0xffb6b6b6),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1),
          ),
        ));
  }
}
