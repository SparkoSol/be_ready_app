import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/event_page_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 20,
            ),
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
                  // 'Most Popular',
                  style: GoogleFonts.oswald(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 30),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 120),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    image: const DecorationImage(
                        image: AssetImage(AppAssets.eventComingUp),
                        fit: BoxFit
                            .fill // image: AssetImage(AppAssets.graphIcon),
                        ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff728FD6),
                          Color(0xffE0DF9F),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
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
                            const Icon(Icons.location_on_outlined, size: 18),
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
                for (int i = 0; i < 10; i++)
                  EventsTile(
                    title: i % 2 == 0 ? 'Brasil Game Show' : "Summer Game Fest",
                    date: 'Oct 12th',
                    participants: const [
                      AppAssets.user,
                      AppAssets.user,
                      AppAssets.user,
                    ],
                    path: AppAssets.otherEvents,
                  )
              ],
            ),
          ),
        ),
      ),
    );
    Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 33,
              right: 33,
              bottom: 20,
            ),
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
                  // 'Most Popular',
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
                            const Icon(Icons.location_on_outlined, size: 18),
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
                for (int i = 0; i < 10; i++)
                  const EventsTile(
                    title: 'Brasil Game Show',
                    date: 'Oct 12th',
                    participants: [
                      AppAssets.user,
                      AppAssets.user,
                      AppAssets.user,
                    ],
                    path: AppAssets.otherEvents,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
