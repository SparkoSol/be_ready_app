import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionOffersPage extends StatefulWidget {
  const SubscriptionOffersPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionOffersPage> createState() => _SubscriptionOffersPageState();
}

class _SubscriptionOffersPageState extends State<SubscriptionOffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
          child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 56),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 45,
              left: 52,
              right: 58),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Subscribe Today!',
                style: GoogleFonts.oswald(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Text(
                'You can cancel your subscription at any time',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white60,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 46),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white30),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF6272E4),
                            Color(0xFFF09793),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 26, horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: const Color(0xFF444A88), width: 0.5),
                ),
                child: Row(
                  children: [
                    Text(
                      '1-Day Trial',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      'Free',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                padding: const EdgeInsets.fromLTRB(31, 37, 24, 17),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFD2876F),
                      Color(0xFF523072),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Premium',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$9.99',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Text(
                      '\$0.33/day',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                ),
                child: Stack(fit: StackFit.loose, children: [
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 120,
                      height: 25,
                      padding: const EdgeInsets.only(top: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Best Value',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0Xff9A6170),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 40,
                      right: 5,
                      left: 20,
                      bottom: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.transparent,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          color: const Color(0xFF444A88), width: 0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Annual (27% off!)',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$87.52',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Text(
                          '\$0.23/day',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 50, bottom: 50),
                child: AppButtonWidget(
                  onPressed: () async {},
                  isIcon: false,
                  title: 'continue',
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
