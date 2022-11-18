import 'package:be_ready_app/src/base/theme.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    Key? key,
    required this.onPressed,
    this.title,
    this.child,
    this.gradiant,
    this.borderRadius,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String? title;
  final Widget? child;
  final List<Color>? gradiant;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        gradient: LinearGradient(
          colors: gradiant ?? AppColors.buttonGradient,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledForegroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          minimumSize: const Size.fromHeight(66),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: child ??
            Text(
              title ?? '',
              style: const TextStyle(fontSize: 18),
            ),
      ),
    );
  }
}
