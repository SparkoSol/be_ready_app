import 'package:be_universe/src/widgets/activities_page_widget.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';

import '../../widgets/thank_you_widget.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  late CustomListViewController<ActivitiesResponse> listViewController;

  @override
  void initState() {
    listViewController = CustomListViewController<ActivitiesResponse>(
      paginatedFunction: (int page, int limit) => ActivitiesApi()
          .getPaginatedActivities(page.toString(), limit.toString()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            // left: 30,
            // right: 30,
            left: 58,
            right: 58,
            bottom: padding.bottom + 20,
            top: padding.top + 56,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const GoalsPageTitle(text: 'Activities'),
              const SizedBox(height: 10),
              const GoalsPageDescription(
                text: 'Based on your results we want to help you improve how '
                    'you’re feeling',
              ),
              const SizedBox(height: 60),
              Expanded(
                child: CustomListView<ActivitiesResponse>.simpler(
                  listViewController: listViewController,
                  baseColor: const Color(0xff2E2340),
                  highLightColor: Colors.white12,
                  shimmerWidget: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                  ),
                  builder: (ctx, data) {
                    return FeelingWidget(
                      text: data.title,
                      path: data.icon,
                      onPressed: () {},
                      duration: data.duration,
                    );
                  },
                ),
              ),

              // FeelingWidget(
              //   text: 'Meditation',
              //   path: 'AppAssets',
              //   onPressed: () {},
              //   duration: '1 hour',
              // ),
              // FeelingWidget(
              //   text: 'Grounding',
              //   path: 'AppAssets.atomIcon',
              //   onPressed: () {},
              //   duration: '1 hour',
              // ),
              // FeelingWidget(
              //   text: 'Hike',
              //   path: AppAssets.starIcon,
              //   onPressed: () {},
              //   duration: '1 hour',
              // ),

              AppButtonWidget(
                onPressed: () async {
                  $showBottomSheet(context, const ThankYouWidget());
                },
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
