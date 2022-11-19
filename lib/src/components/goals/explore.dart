import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/custom_slider_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  double bodySliderValue = 8;
  double mindSliderValue = 3;
  double spiritValue = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: MediaQuery.of(context).viewPadding.top + 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GoalsPageTitle(text: 'Explore'),
              const GoalsPageDescription(text: 'Additional Courses'),
        SizedBox(height: 50,),
              RedText(text: 'Mind'),
                const Spacer(),
              AppButtonWidget(onPressed: () {}, title: 'See results')
            ],
          ),
        ),
      ),
    );
  }
}

class GoalsPageTitle extends StatelessWidget {
  final String text;

  const GoalsPageTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.oswald(
        fontSize: 33,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class GoalsPageDescription extends StatelessWidget {
  final String text;

  const GoalsPageDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.w300),
    );
  }
}
