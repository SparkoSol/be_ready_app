import 'package:be_ready_app/src/base/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class AppButtonWidget extends StatelessWidget {
//   const AppButtonWidget({
//     Key? key,
//     required this.onPressed,
//     this.title,
//     this.child,
//     this.gradiant,
//     this.borderRadius,
//   }) : super(key: key);
//
//   final VoidCallback onPressed;
//   final String? title;
//   final Widget? child;
//   final List<Color>? gradiant;
//   final double? borderRadius;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(borderRadius ?? 16),
//         gradient: LinearGradient(
//           colors: gradiant ?? AppColors.buttonGradient,
//         ),
//       ),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           disabledForegroundColor: Colors.transparent,
//           disabledBackgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           backgroundColor: Colors.transparent,
//           minimumSize: const Size.fromHeight(66),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         onPressed: onPressed,
//         child: child ??
//             Text(
//               title ?? '',
//               style: const TextStyle(fontSize: 18),
//             ),
//       ),
//     );
//   }
// }

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.isIcon = true})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final bool? isIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: AppColors.buttonGradient,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Text(
                title.toUpperCase(),
                style: GoogleFonts.oswald(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
            isIcon == true
                ? Positioned(
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
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class AppCourseButtonWidget extends StatelessWidget {
  const AppCourseButtonWidget({
    Key? key,
    this.title,
    required this.onTap,
    this.isShadowed = false,
  }) : super(key: key);

  final bool isShadowed;
  final String? title;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
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
            title ?? "Go to Coursework",
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
