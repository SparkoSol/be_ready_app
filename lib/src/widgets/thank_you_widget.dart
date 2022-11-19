import 'dart:ui';

import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYouWidget extends StatelessWidget {
  const ThankYouWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.starsIcon,
            ),
          ),
          color: Color(0xFF0B002A),
          gradient:
              LinearGradient(colors: [Color(0xFF728FD6), Color(0xFFE0DF9F)]),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            image: DecorationImage(image: AssetImage(AppAssets.starsIcon)),
            color: Color(0xFF0B002A),
          ),
          margin: const EdgeInsets.all(2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Transform.translate(
                  offset: const Offset(0, -35),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF0B002A),
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF728FD6),
                          Color(0xFFE0DF9F),
                        ],
                      ),
                    ),
                    child: Container(
                      height: 54,
                      width: 55,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0B002A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child:
                    Image.asset(AppAssets.thumbIcon, width: 100, height: 120),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Thank You',
                  style: GoogleFonts.oswald(fontSize: 30, color: Colors.white),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'You are consciously evolving every day',
                  style: GoogleFonts.oswald(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                child: AppButtonWidget(
                  onPressed: () => Navigator.of(context).pop(),
                  title: 'Back To HomePage',
                ),
              ),
            ],
          ),
        ));
  }
}

dynamic $showBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: child),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
  );
}
