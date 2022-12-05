import 'package:be_universe/src/base/modals/error_dialog.dart';
import 'package:be_universe/src/components/main_menu/events/controller.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/event_page_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late CustomListViewController<EventsResponse> listController;
  late CustomListViewController<BannerResponse> bannerController;

  @override
  void initState() {
    super.initState();
    listController = CustomListViewController<EventsResponse>(
      listDataFunction: () => EventsApi().getAllEvents(),
    );
    bannerController = CustomListViewController<BannerResponse>(
      dataFunction: () => EventsApi().getBanner(),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => loadBanner());
  }

  Future<void> loadBanner() async {
    try {
      bannerResponse = await EventsApi().getBanner();
      setState(() {});
    } catch (e) {
      ErrorDialog(error: DioException.withDioError(e));
    }
  }

  var eventController = EventsController();
  late BannerResponse bannerResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
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
                  onRefresh: listController.refresh,
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
                    children: [
                      const GoalsPageTitle(text: 'Events'),
                      const GoalsPageDescription(
                        text: 'Participate. Download. Attend.',
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Coming up',
                        style: GoogleFonts.oswald(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      if (!eventController.loading)
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 30),
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 150),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(
                                bannerResponse.imageName,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      Text(
                        'Other Events',
                        style: GoogleFonts.oswald(
                          height: 2,
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
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
                      child: EventsTile(
                        title: data.name,
                        date: DateTime.parse(data.date).dateFormat,
                        path: data.imageName.fileUrl,
                        participants: const [],
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
