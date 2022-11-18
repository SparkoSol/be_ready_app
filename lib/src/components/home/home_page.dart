import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/widgets/be_universe_tile_widget.dart';
import 'package:be_ready_app/src/widgets/main_menu_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0b002a),
      appBar: AppBar(
        title: const Text('DashBoard'),
        backgroundColor: const Color(0xFF4F2A98),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuWidget(
                  onPressed: () {},
                  text: 'Daily check-In',
                  path: AppAssets.graphIcon,
                ),
                MainMenuWidget(
                  onPressed: () {},
                  text: 'Resources',
                  path: AppAssets.graphIcon,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainMenuWidget(
                  onPressed: () {},
                  text: 'Events',
                  path: AppAssets.calenderIcon,
                ),
                MainMenuWidget(
                  onPressed: () {},
                  text: 'Be Connected',
                  path: AppAssets.profileIcon,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            UniverseTileWidget(
              onPressed: () {},
              text: 'Mind',
              path: AppAssets.skullIcon,
            ),
            const SizedBox(
              height: 5,
            ),
            UniverseTileWidget(
              onPressed: () {},
              text: 'Body',
              path: AppAssets.heartyIcon,
            ),
            const SizedBox(
              height: 5,
            ),
            UniverseTileWidget(
              onPressed: () {},
              text: 'Spirit',
              path: AppAssets.buddIcon,
            ),
          ],
        ),
      ),
    );
  }
}
