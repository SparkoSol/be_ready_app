import 'dart:ui';

import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/main_menu/resources/resources_controller.dart';
import 'package:be_ready_app/src/components/main_menu/resources/widgets/audio_player_sheet.dart';
import 'package:be_ready_app/src/components/main_menu/resources/widgets/pdf_dialog.dart';
import 'package:be_ready_app/src/components/main_menu/resources/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaWidget extends StatelessWidget {
  const MediaWidget(
      {Key? key,
      required this.path,
      required this.controller,
      required this.index})
      : super(key: key);
  final String path;
  final ResourceController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    print(
        'https://192.168.11.193:3002/uploads/${controller.dataList[index].filename}');
    late String icon;
    switch (controller.type) {
      case 'Video':
        icon = AppAssets.videoIcon;
        break;
      case 'Book':
        icon = AppAssets.bookIcon;

        break;
      case 'Audio':
        icon = AppAssets.audioIcon;

        break;
      case 'Podcast':
        icon = AppAssets.podcastIcon;

        break;
      case 'Quote':
        icon = AppAssets.quotesIcon;
        break;
    }
    return Container(
      padding: const EdgeInsets.only(top: 51),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: controller.dataList[index].thumbnail == ''
              ? const AssetImage(AppAssets.backgroundImage)
              : NetworkImage(
                      'https://192.168.11.193:3002/uploads/${controller.dataList[index].thumbnail}')
                  as ImageProvider,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              switch (controller.type) {
                case 'Video':
                  AppNavigation.to(
                      context,
                      VideoPlayerWidget(
                          url:
                              'https://192.168.11.193:3002/uploads/${controller.dataList[index].filename}'));

                  break;
                case 'Book':
                  PdfDialog(
                          url:
                              'https://192.168.11.193:3002/uploads/${controller.dataList[index].filename}')
                      .show(context);

                  break;
                case 'Audio':
                  AudioPlayerWidget(
                          url:
                              'https://192.168.11.193:3002/uploads/${controller.dataList[index].filename}',
                          title: controller.dataList[index].title)
                      .show(context);
                  break;
                case 'Podcast':
                  break;
                case 'Quote':
                  break;
              }
            },
            child: Container(
              width: 63,
              height: 63,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  stops: [0.1, 0.8],
                  end: Alignment.bottomRight,
                  begin: Alignment.centerLeft,
                  colors: [
                    Color(0xFFF0D781),
                    Color(0xFFDA8B6D),
                    // Color(0xff56528E),
                  ],
                ),
              ),
              child: Image.asset(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 43),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(21),
                    margin: const EdgeInsets.only(bottom: 1),
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.4),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(210, 135, 111, 1),
                          Color.fromRGBO(82, 48, 114, 1),
                        ],
                      ),
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(35),
                        bottomLeft: Radius.circular(35),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Share with a Friend',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                stops: const [0.5, 1],
                                colors: [
                                  Colors.white.withOpacity(0.1),
                                  Colors.white,
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Like',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
