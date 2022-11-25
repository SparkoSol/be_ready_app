import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/components/main_menu/events/controller.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/event_page_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class EventsPage extends ControlledWidget<EventsController> {
  EventsPage({Key? key, required this.eventsController})
      : super(key: key, controller: eventsController);
  final EventsController eventsController;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with ControlledStateMixin {
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
            child: widget.eventsController.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.indigo,
                    ),
                  )
                : CustomScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    slivers: [
                      CupertinoSliverRefreshControl(
                        onRefresh: widget.eventsController.initialization,
                        builder: (context,
                            refreshState,
                            pulledExtent,
                            refreshTriggerPullDistance,
                            refreshIndicatorExtent) {
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
                              'Most Popular',
                              style: GoogleFonts.oswald(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 30),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(top: 100),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                image: const DecorationImage(
                                  image: AssetImage(AppAssets.graphIcon),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff728FD6),
                                      Color(0xffE0DF9F),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mon, Apr 18 · 21:00 Pm ',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'La Rosalia',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined,
                                            size: 18),
                                        const SizedBox(width: 2),
                                        Text(
                                          'Palau Sant Jordi, Barcelona',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
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
                              EventsTile(
                                title: widget.eventsController.events[i].name,
                                date: widget.eventsController.events[i].date,
                                participants: const [
                                  AppAssets.user,
                                  AppAssets.user,
                                  AppAssets.user,
                                ],
                                path: AppAssets.otherEvents,
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
