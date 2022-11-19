import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/goals/activites_page.dart';
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
              SizedBox(
                height: 50,
              ),
              RedText(text: 'Mind'),
              AppCourseButtonWidget(
                onTap: () {},
              ),
              RedText(text: 'Body'),
              AppCourseButtonWidget(
                onTap: () {},
              ),
              RedText(text: 'Spirit'),
              AppCourseButtonWidget(
                onTap: () {},
              ),
              const Spacer(),
              AppButtonWidget(
                  onPressed: () {
                    AppNavigation.to(context, ActivitesPage());
                  },
                  title: 'SUPPORTIVE ACTIVITIES')
            ],
          ),
        ),
      ),
    );
  }
}
