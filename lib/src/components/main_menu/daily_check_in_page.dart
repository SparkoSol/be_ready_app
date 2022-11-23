import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/custom_slider_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:be_ready_app/src/widgets/thank_you_widget.dart';
import 'package:flutter/material.dart';

class DailyCheckInPage extends StatefulWidget {
  const DailyCheckInPage({Key? key}) : super(key: key);

  @override
  State<DailyCheckInPage> createState() => _DailyCheckInPageState();
}

class _DailyCheckInPageState extends State<DailyCheckInPage> {
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
          padding: EdgeInsets.fromLTRB(
            58,
            MediaQuery.of(context).viewPadding.top + 56,
            58,
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GoalsPageTitle(text: 'Daily Check-In'),
              const GoalsPageDescription(text: 'Aware. Acknowledge. Accept.'),
              CustomSlider(
                value: mindSliderValue,
                callback: (v) {
                  mindSliderValue = v;
                  setState(() {});
                },
                text: 'My Mind Feels',
              ),
              CustomSlider(
                value: bodySliderValue,
                callback: (v) {
                  bodySliderValue = v;
                  setState(() {});
                },
                text: 'My Body Feels',
              ),
              CustomSlider(
                value: spiritValue,
                callback: (v) {
                  spiritValue = v;
                  setState(() {});
                },
                text: 'My Spirit Feels',
              ),
              const Spacer(),
              AppButtonWidget(
                onPressed: () {
                  $showBottomSheet(context, const ThankYouWidget());
                },
                title: 'See results',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
