import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/components/main_menu/events/controller.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/event_page_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class EventsPage extends ControlledWidget<EventsController> {
  const EventsPage({Key? key, required this.eventsController})
      : super(key: key, controller: eventsController);
  final EventsController eventsController;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with ControlledStateMixin {
  // late CustomListViewController<EventsResponse> listController;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   listController = CustomListViewController<EventsResponse>(
  //     dataFunction: () => Api().getAllEvents(),
  //   );
  // }
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
                  onRefresh: widget.eventsController.initialization,
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
                        'Upcoming',
                        style: GoogleFonts.oswald(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 30),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 150),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          image: const DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                              AppAssets.userIcon,
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
                      for (int i = 0;
                          i < widget.eventsController.events.length;
                          i++)
                        GestureDetector(
                          // onTap: () => AppNavigation.to(
                          //   context,
                          //   EventsDetailsPage(
                          //     title:
                          //         widget.eventsController.events[i].name,
                          //     date:
                          //         widget.eventsController.events[i].date,
                          //     location: widget
                          //         .eventsController.events[i].location,
                          //     imagePath: AppAssets.temple,
                          //     participants: const [
                          //       AppAssets.user,
                          //       AppAssets.user,
                          //       AppAssets.user,
                          //       AppAssets.user,
                          //       AppAssets.user,
                          //       AppAssets.user,
                          //     ],
                          //   ),
                          // ),
                          child: EventsTile(
                            title: widget.eventsController.events[i].name,
                            date: DateTime.parse(
                                    widget.eventsController.events[i].date)
                                .dateFormat,
                            // participants: const [
                            //   AppAssets.user,
                            //   AppAssets.user,
                            //   AppAssets.user,
                            // ],
                            path: widget
                                .eventsController.events[i].imageName.fileUrl,
                            participants: const [],
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
