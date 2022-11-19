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
                title,
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
