import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/goals/explore.dart';
import 'package:be_universe/src/services/daily_check_in_service.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/custom_slider_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe/src/widgets/thank_you_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';

class DailyCheckInPage extends StatefulWidget {
  const DailyCheckInPage({Key? key}) : super(key: key);

  @override
  State<DailyCheckInPage> createState() => _DailyCheckInPageState();
}

class _DailyCheckInPageState extends State<DailyCheckInPage> {
  double bodySliderValue = 1;
  double mindSliderValue = 1;
  double spiritValue = 1;
  String userId = '';
  late CustomListViewController<DailyCheckInResponse> listController;

  @override
  void initState() {
    super.initState();
    listController = CustomListViewController<DailyCheckInResponse>(
      dataFunction: () => DailyCheckInApi().getDailyCheckIn(
        AppData().readLastUser().userid,
      ),
    );
  }

  // Future<void> getDailyCheckIns() async {
  //   try {
  //     final userData = Api.getProfileData();
  //     userId = userData['userId']!;
  //     print('user data ${userData}');
  //     print('userID ${userData['userId']}');
  //     dynamic response =
  //         await DailyCheckInService().getDailyCheckInData(userId);
  //     spiritValue = response.mySpiritFeels.toDouble();
  //     mindSliderValue = response.myMindFeels.toDouble();
  //     bodySliderValue = response.myBodyFeels.toDouble();
  //     setState(() {});
  //   } catch (e) {
  //     ErrorDialog(error: e).show(context);
  //
  //     //     $showSnackBar(context, e.toString());
  //   }
  // }
  var _absorb = false;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: _absorb,
      child: Scaffold(
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GoalsPageTitle(text: 'Daily Check-In'),
                  const GoalsPageDescription(
                      text: 'Aware. Acknowledge. Accept.'),
                  CustomSlider(
                    value: mindSliderValue,
                    callback: (v) async {
                      mindSliderValue = v;
                      setState(() {});
                    },
                    text: 'My Mind Feels',
                  ),
                  CustomSlider(
                    value: bodySliderValue,
                    callback: (v) async {
                      bodySliderValue = v;
                      setState(() {});
                    },
                    text: 'My Body Feels',
                  ),

                  CustomSlider(
                    value: spiritValue,
                    callback: (v) async {
                      spiritValue = v;
                      setState(() {});
                    },
                    text: 'My Spirit Feels',
                  ),

                  // CustomListView<DailyCheckInResponse>.simpler(
                  //   listViewController: listController,
                  //   builder: (context, data) {
                  //     spiritValue = data.mySpiritFeels.toDouble();
                  //     mindSliderValue = data.myMindFeels.toDouble();
                  //     bodySliderValue = data.myBodyFeels.toDouble();
                  //     return Column(children: []);
                  //   },
                  // ),
                  const SizedBox(height: 55),
                  AppButtonWidget(
                    before: () => setState(() => _absorb = true),
                    after: () => setState(() => _absorb = false),
                    onPressed: () => sendDailyCheckIn(
                        spiritValue, mindSliderValue, bodySliderValue),
                    title: 'See results',
                  ),
                  const SizedBox(height: 55)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendDailyCheckIn(double spirit, double mind, double body) async {
    try {
      await DailyCheckInService().sendDailyCheckInData(
        DailyCheckInModel(
          userId: AppData().readLastUser().userid,
          myBodyFeels: body.toInt(),
          myMindFeels: mind.toInt(),
          mySpiritFeels: spirit.toInt(),
        ),
      );
      if (!mounted) return;
      if (mindSliderValue < 5 || bodySliderValue < 5 || spiritValue < 5) {
        AppNavigation.toReplace(
          context,
          ExplorePage(
            bodyValue: bodySliderValue,
            mindValue: mindSliderValue,
            spiritValue: spiritValue,
          ),
        );
      } else {
        $showBottomSheet(context, const ThankYouWidget());
      }
    } catch (_) {
      rethrow;
    }
  }
}
