import 'package:be_ready_app/src/base/modals/error_dialog.dart';
import 'package:be_ready_app/src/services/daily_check_in_service.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/custom_slider_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:be_ready_app/src/widgets/thank_you_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

class DailyCheckInPage extends StatefulWidget {
  const DailyCheckInPage({Key? key}) : super(key: key);

  @override
  State<DailyCheckInPage> createState() => _DailyCheckInPageState();
}

class _DailyCheckInPageState extends State<DailyCheckInPage> {
  double bodySliderValue = 8;
  double mindSliderValue = 3;
  double spiritValue = 6;
  String userId = '';

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => sendDailyCheckIn(0, 0, 0));
    super.initState();
  }

  Future<void> getDailyCheckIns() async {
    try {
      final userData = await Api.getProfileDate();
      userId = userData['userId']!;
      print('user data ${userData}');
      print('userID ${userData['userId']}');
      dynamic response = await DailyCheckInService().getDailyCheckInData();
      spiritValue = response.mySpiritFeels.toDouble();
      mindSliderValue = response.myMindFeels.toDouble();
      bodySliderValue = response.myBodyFeels.toDouble();
      setState(() {});
    } catch (e) {
      ErrorDialog(error: e).show(context);

      //     $showSnackBar(context, e.toString());
    }
  }

  Future<void> sendDailyCheckIn(double spirit, double mind, double body) async {
    try {
      final userData = await Api.getProfileDate();
      userId = userData['userId']!;
      print('user data ${userData}');
      print('userID ${userData['userId']}');
      final response = await Awaiter.process(
          context: context,
          future: DailyCheckInService().sendDailyCheckInData(DailyCheckInModel(
              userId: '${userData['userId']}',
              myBodyFeels: body.toInt(),
              myMindFeels: mind.toInt(),
              mySpiritFeels: spirit.toInt())),
          arguments: 'loading...');
      print(response.myMindFeels);
      spiritValue = response.mySpiritFeels.toDouble();
      mindSliderValue = response.myMindFeels.toDouble();
      bodySliderValue = response.myBodyFeels.toDouble();
      setState(() {});
    } catch (e) {
      // $showSnackBar(context, e.toString());
      ErrorDialog(error: e).show(context);
    }
  }

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
            top: MediaQuery.of(context).viewPadding.top + 56,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GoalsPageTitle(text: 'Daily Check-In'),
              const GoalsPageDescription(text: 'Aware. Acknowledge. Accept.'),
              CustomSlider(
                value: mindSliderValue,
                callback: (v) async {
                  mindSliderValue = v;
                  await sendDailyCheckIn(
                      spiritValue, mindSliderValue, bodySliderValue);
                },
                text: 'My Mind Feels',
              ),
              CustomSlider(
                value: bodySliderValue,
                callback: (v) async {
                  bodySliderValue = v;
                  await sendDailyCheckIn(
                      spiritValue, mindSliderValue, bodySliderValue);
                },
                text: 'My Body Feels',
              ),
              CustomSlider(
                value: spiritValue,
                callback: (v) async {
                  spiritValue = v;
                  await sendDailyCheckIn(
                      spiritValue, mindSliderValue, bodySliderValue);
                },
                text: 'My Spirit Feels',
              ),
              const Spacer(),
              AppButtonWidget(
                onPressed: () {
                  $showBottomSheet(context, const ThankYouWidget());
                },
                title: 'See results',
              )
            ],
          ),
        ),
      ),
    );
  }
}
