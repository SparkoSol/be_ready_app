import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/be_universe_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/app_bar.dart';
import '../journey/journey_page.dart';

class BeUniverseView extends StatefulWidget {
  const BeUniverseView({Key? key}) : super(key: key);

  @override
  State<BeUniverseView> createState() => _BeUniverseViewState();
}

class _BeUniverseViewState extends State<BeUniverseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top + 56,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 55,
              right: 55,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'BeUniverse',
                  style: GoogleFonts.oswald(
                    fontSize: 33,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Discover. Create. Expand',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    AppAssets.temple,
                    height: 200,
                  ),
                ),
                UniverseTileWidget(
                  onPressed: () {
                    AppNavigation.to(
                      context,
                      const JourneyHomePage(therapy: TherapyType.mind),
                    );
                  },
                  text: 'Mind',
                  path: AppAssets.skullIcon,
                ),
                UniverseTileWidget(
                  onPressed: () {
                    AppNavigation.to(
                      context,
                      const JourneyHomePage(therapy: TherapyType.body),
                    );
                  },
                  text: 'Body',
                  path: AppAssets.heartyIcon,
                ),
                UniverseTileWidget(
                  onPressed: () {
                    AppNavigation.to(
                      context,
                      const JourneyHomePage(therapy: TherapyType.spirit),
                    );
                  },
                  text: 'Spirit',
                  path: AppAssets.buddIcon,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum TherapyType { mind, body, spirit }
