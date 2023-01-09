import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_network_image.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class EventsDetailsPage extends StatefulWidget {
  const EventsDetailsPage(
      {Key? key,
      required this.title,
      // required this.participants,
      required this.description,
      required this.date,
      required this.imagePath,
      required this.location})
      : super(key: key);
  final String imagePath;
  final String title;
  final String date;
  final String location;
  final String description;

  // final List<String> participants;

  @override
  State<EventsDetailsPage> createState() => _EventsDetailsPageState();
}

class _EventsDetailsPageState extends State<EventsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(),
      // persistentFooterButtons: [
      //   AppButtonWidget(
      //     onPressed: () async {},
      //     title: 'Participate',
      //     isIcon: false,
      //   )
      // ],
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 56, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: AppNetworkImage(
                    borderRadius: 20,
                    url: widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff728FD6),
                        Color(0xffE0DF9F),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.description,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 18),
                          const SizedBox(width: 2),
                          Text(
                            widget.location,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            DateTime.parse(widget.date).dateTimeFormat,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                // Padding(
                //   padding: const EdgeInsets.only(left: 10),
                //   child: Text(
                //     'Participants',
                //     style: GoogleFonts.oswald(
                //       height: 2,
                //       fontSize: 19,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // for (int i = 0; i < widget.participants.length; i++)
                //   ListTile(
                //     title: Text(
                //       'Participant Name',
                //       style: GoogleFonts.poppins(
                //         fontSize: 13,
                //         fontWeight: FontWeight.w300,
                //         color: Colors.white,
                //       ),
                //     ),
                //     leading: Container(
                //       width: 40,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         image: DecorationImage(
                //           image: AssetImage(widget.participants[i]),
                //           fit: BoxFit.cover,
                //         ),
                //         color: const Color(0xffb6b6b6),
                //         shape: BoxShape.circle,
                //         border: Border.all(color: Colors.white, width: 1),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
