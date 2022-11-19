import 'package:be_ready_app/src/base/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    Key? key,
    required this.onPressed,
    this.title,
    this.child,
    this.gradiant,
    this.borderRadius,
    this.height,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String? title;
  final Widget? child;
  final List<Color>? gradiant;
  final double? borderRadius;
  final double? height;

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
          minimumSize: Size.fromHeight(height ?? 66),
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

class AppCourseButtonWidget extends StatelessWidget {
  const AppCourseButtonWidget({
    Key? key,
    required this.title,
    required this.onTap,
    this.isShadowed = false,
  }) : super(key: key);

  final bool isShadowed;
  final String title;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(120),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF728FD6),
            Color(0xFFD8D9A3),
          ],
        ),
        boxShadow: isShadowed
            ? [
                BoxShadow(
                  color: const Color(0xFFD8D9A3).withOpacity(0.25),
                  offset: const Offset(6, 2),
                  spreadRadius: 5,
                  blurRadius: 10,
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(120),
          ),
          padding: const EdgeInsets.symmetric(vertical: 17),
          disabledForegroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        onPressed: onTap,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: const Color(0xFF140D36),
            ),
          ),
          const SizedBox(width: 18),
          const Icon(
            Icons.keyboard_double_arrow_right,
            color: Color(0xFF140D36),
          )
        ]),
      ),
    );
  }
}
