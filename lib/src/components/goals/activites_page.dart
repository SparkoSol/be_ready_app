import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/widgets/activities_page_widget.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:flutter/material.dart';

class ActivitesPage extends StatefulWidget {
  const ActivitesPage({Key? key}) : super(key: key);

  @override
  State<ActivitesPage> createState() => _ActivitesPageState();
}

class _ActivitesPageState extends State<ActivitesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            left: 58,
            right: 58,
            bottom: 20,
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GoalsPageTitle(text: 'Activities'),
              const GoalsPageDescription(
                text: 'Based on your results we want to help you improve how '
                    'you’re feeling',
              ),
              const SizedBox(height: 30),
              FeelingWidget(
                text: 'Meditation',
                path: AppAssets.deltaIcon,
                onPressed: () {},
                duration: '1 hour',
              ),
              FeelingWidget(
                text: 'Grounding',
                path: AppAssets.atomIcon,
                onPressed: () {},
                duration: '1 hour',
              ),
              FeelingWidget(
                text: 'Hike',
                path: AppAssets.starIcon,
                onPressed: () {},
                duration: '1 hour',
              ),
              const Spacer(),
              AppButtonWidget(
                onPressed: () {},
                title: 'I’m in!',
                isIcon: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
