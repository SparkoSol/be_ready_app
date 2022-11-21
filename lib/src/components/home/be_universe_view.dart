import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/be_universe_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      // appBar: AppBarWidget(),
      body: BackgroundImageWidget(
          child: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: 55,
            right: 55,
            bottom: 20,
            top: MediaQuery.of(context).viewPadding.top + 56),
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
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Image.asset(AppAssets.temple, width: 243, height: 270),
            ),
            UniverseTileWidget(
              onPressed: () {},
              text: 'Mind',
              path: AppAssets.skullIcon,
            ),
            UniverseTileWidget(
              onPressed: () {},
              text: 'Body',
              path: AppAssets.heartyIcon,
            ),
            UniverseTileWidget(
              onPressed: () {},
              text: 'Spirit',
              path: AppAssets.buddIcon,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      )),
    );
  }
}