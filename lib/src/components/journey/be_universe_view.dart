import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/be_universe_tile_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/utils/awaiter.dart';

import '../../widgets/app_bar.dart';
import 'journey_page.dart';

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
      appBar: const AppBarWidget(),
      body: BackgroundImageWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 56,
              left: 55,
              right: 55,
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
                // const SizedBox(height: 5),
                Text(
                  'Discover. Create. Expand',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    AppAssets.temple,
                    height: 190,
                  ),
                ),
                UniverseTileWidget(
                  onPressed: () => getJourneys('Mind', TherapyType.mind),
                  text: 'Mind',
                  path: AppAssets.skullIcon,
                ),
                UniverseTileWidget(
                  onPressed: () => getJourneys('Body', TherapyType.body),
                  text: 'Body',
                  path: AppAssets.heartyIcon,
                ),
                UniverseTileWidget(
                  onPressed: () => getJourneys('Spirit', TherapyType.spirit),
                  text: 'Spirit',
                  path: AppAssets.buddIcon,
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
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

enum TherapyType { mind, body, spirit }
