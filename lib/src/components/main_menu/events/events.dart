import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/main_menu/events/events_details.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_network_image.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/event_page_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late CustomListViewController<EventsResponse> listController;
  late CustomListViewController<List<BannerResponse>> bannerController;

  @override
  void initState() {
    super.initState();
    listController = CustomListViewController<EventsResponse>(
      listDataFunction: () => EventsApi().getAllEvents(),
    );
    bannerController = CustomListViewController<List<BannerResponse>>(
      dataFunction: () => EventsApi().getBanner(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 33,
              right: 33,
              bottom: 20,
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () => Future.wait([
                    listController.refresh(),
                    bannerController.refresh(),
                  ]),
                  builder: (context, refreshState, pulledExtent,
                      refreshTriggerPullDistance, refreshIndicatorExtent) {
                    return const CupertinoActivityIndicator(
                      color: Colors.white,
                      radius: 15,
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      GoalsPageTitle(text: 'Events'),
                      GoalsPageDescription(
                        text: 'Participate. Download. Attend.',
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    'Coming up',
                    style: GoogleFonts.oswald(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                CustomListView<List<BannerResponse>>.sliver(
                  listViewController: bannerController,
                  baseColor: const Color(0xff2E2340),
                  shimmerCount: 1,
                  highLightColor: Colors.white12,
                  errorWidget: const SizedBox(),
                  noDataWidget: const Text(
                    'There is no upcoming event',
                    style: TextStyle(color: Colors.white),
                  ),
                  shimmerWidget: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const SizedBox(
                      height: 80,
                      width: double.infinity,
                    ),
                  ),
                  builder: (ctx, data) {
                    if (data.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Text(
                          'There is no upcoming event',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 30),
                        child: AppNetworkImage(
                          url: data.first.imageName,
                          width: 360,
                          height: 225,
                          borderRadius: 30,
                        ),
                      ),
                      // child: Container(
                      //   margin: const EdgeInsets.only(top: 5, bottom: 30),
                      //   width: double.infinity,
                      //   padding: const EdgeInsets.only(top: 150),
                      //   decoration: BoxDecoration(
                      //     color: Colors.orange,
                      //     // image: DecorationImage(
                      //     //   fit: BoxFit.cover,
                      //     //   image: NetworkImage(
                      //     //     data.first.imageName.fileUrl,
                      //     //   ),
                      //     // ),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //
                      // ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Text(
                    'Other Events',
                    style: GoogleFonts.oswald(
                      height: 2,
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                CustomListView<EventsResponse>.sliver(
                  listViewController: listController,
                  baseColor: const Color(0xff2E2340),
                  highLightColor: Colors.white12,
                  shimmerWidget: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                  ),
                  builder: (ctx, data) {
                    return GestureDetector(
                      onTap: () => AppNavigation.to(
                        context,
                        EventsDetailsPage(
                            title: data.name,
                            date: data.date,
                            description: data.description,
                            imagePath: data.imageName,
                            location: data.location),
                      ),
                      child: EventsTile(
                        event: data,
                        // title: data.name,
                        // date: DateTime.parse(data.date).monthDate,
                        // path: data.imageName,
                        // participants: const [],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
