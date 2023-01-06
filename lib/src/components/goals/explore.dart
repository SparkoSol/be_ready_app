import 'package:be_universe/src/base/modals/app_snackbar.dart';
import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/goals/activites_page.dart';
import 'package:be_universe/src/components/journey/be_universe_view.dart';
import 'package:be_universe/src/components/journey/journey_page.dart';
import 'package:be_universe/src/components/subscription/offers/subscription_offers_page.dart';
import 'package:be_universe/src/services/daily_check_in_service.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/premium/premium_controller.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

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
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            left: 56,
            right: 56,
            bottom: padding.bottom + 20,
            top: padding.top + 56,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GoalsPageTitle(text: 'Explore'),
              const GoalsPageDescription(text: 'Additional Courses'),
              const SizedBox(height: 50),
              if (widget.mindValue < 5) ...[
                const RedText(text: 'Mind'),
                AppCourseButtonWidget(
                  onTap: () {
                    if (PremiumController.instance.isPremiumUser) {
                      getJourneys('Mind', TherapyType.mind);
                    } else {
                      $showSnackBar(
                          context, 'You need to purchase exclusive context');
                      AppNavigation.to(context, SubscriptionOffersPage());
                    }
                  },
                ),
              ],
              if (widget.bodyValue < 5) ...[
                const RedText(text: 'Body'),
                AppCourseButtonWidget(
                  onTap: () {
                    if (PremiumController.instance.isPremiumUser) {
                      getJourneys('Body', TherapyType.body);
                    } else {
                      $showSnackBar(
                          context, 'You need to purchase exclusive context');
                      AppNavigation.to(context, SubscriptionOffersPage());
                    }
                  },
                ),
              ],
              if (widget.spiritValue < 5) ...[
                const RedText(text: 'Spirit'),
                AppCourseButtonWidget(onTap: () {
                  if (PremiumController.instance.isPremiumUser) {
                    getJourneys('Spirit', TherapyType.spirit);
                  } else {
                    $showSnackBar(
                        context, 'You need to purchase exclusive context');
                    AppNavigation.to(context, SubscriptionOffersPage());
                  }
                }),
              ],
              const Spacer(),
              AppButtonWidget(
                onPressed: sendDailyCheckIn,
                title: 'SUPPORTIVE ACTIVITIES',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendDailyCheckIn() async {
    try {
      await DailyCheckInService().sendDailyCheckInData(
        DailyCheckInModel(
          userId: AppData().readLastUser().userid,
          myBodyFeels: widget.bodyValue.toInt(),
          myMindFeels: widget.mindValue.toInt(),
          mySpiritFeels: widget.spiritValue.toInt(),
        ),
      );
      if (!mounted) return;
      AppNavigation.toReplace(context, const ActivitiesPage());
    } catch (_) {
      rethrow;
    }
  }

  Future<void> getJourneys(String type, TherapyType tType) async {
    try {
      final response = await Awaiter.process(
          future: JourneyApi()
              .getPaginatedJourneys(type, 0.toString(), 6.toString()),
          context: context,
          arguments: 'saving...');
      if (!mounted) return;
      AppNavigation.to(
        context,
        JourneyHomePage(
          therapy: tType,
          data: response,
        ),
      );
    } catch (e) {
      ErrorDialog(error: DioException.withDioError(e)).show(context);
    }
  }
}
