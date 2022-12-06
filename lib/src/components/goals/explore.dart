import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/goals/activites_page.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage(
      {Key? key,
      required this.spiritValue,
      required this.bodyValue,
      required this.mindValue})
      : super(key: key);
  final double bodyValue;
  final double spiritValue;
  final double mindValue;

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            // left: 30,
            // right: 30,
            left: 56,
            right: 56,
            bottom: 20,
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GoalsPageTitle(text: 'Explore'),
              const GoalsPageDescription(text: 'Additional Courses'),
              const SizedBox(height: 50),
              if (widget.mindValue < 5) ...[
                const RedText(text: 'Mind'),
                AppCourseButtonWidget(onTap: () {}),
              ],
              if (widget.bodyValue < 5) ...[
                const RedText(text: 'Body'),
                AppCourseButtonWidget(onTap: () {}),
              ],
              if (widget.spiritValue < 5) ...[
                const RedText(text: 'Spirit'),
                AppCourseButtonWidget(onTap: () {}),
              ],
              const Spacer(),
              AppButtonWidget(
                onPressed: () async {
                  AppNavigation.to(context, const ActivitesPage());
                },
                title: 'SUPPORTIVE ACTIVITIES',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
