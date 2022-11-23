import 'dart:ui';

import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYouWidget extends StatelessWidget {
  const ThankYouWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF728FD6), Color(0xFFE0DF9F)],
          ),
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
              // image: DecorationImage(
              //   image: AssetImage(AppAssets.starsIcon),
              //   fit: BoxFit.contain
              // ),
              color: Color(0xFF0B002A),
            ),
            margin: const EdgeInsets.fromLTRB(2, 2, 2, 0),
            padding: EdgeInsets.fromLTRB(
              30,
              20,
              30,
              10 + MediaQuery.of(context).padding.bottom,
            ),
            child: Stack(children: [
              Image.asset(AppAssets.starsIcon),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Transform.translate(
                      offset: const Offset(0, -60),
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
                          height: 79,
                          width: 79,
                          margin: const EdgeInsets.only(top: 5),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0B002A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 15),
                    //   child: Image.asset(
                    //     AppAssets.thumbIcon,
                    //   ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Thank You',
                      style:
                          GoogleFonts.oswald(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: AppButtonWidget(
                      title: 'Back To HomePage',
                      onPressed: () {
                        AppNavigation.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ])));
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
