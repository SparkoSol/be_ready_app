import 'dart:ui';

import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/error_dialog.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/main_menu/resources/widgets/audio_player_sheet.dart';
import 'package:be_universe/src/components/main_menu/resources/widgets/pdf_dialog.dart';
import 'package:be_universe/src/components/main_menu/resources/widgets/video_player_widget.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';
import 'package:share_plus/share_plus.dart';

class MediaWidget extends StatefulWidget {
  const MediaWidget(
      {Key? key,
      required this.path,
      required this.type,
      required this.resource})
      : super(key: key);
  final String path;
  final String type;
  final ResourceResponse resource;

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.resource.filename.fileUrl);
    late String icon;
    switch (widget.type) {
      case 'Videos':
        icon = AppAssets.videoIcon;
        break;
      case 'Books':
        icon = AppAssets.bookIcon;

        break;
      case 'Audios':
        icon = AppAssets.audioIcon;

        break;
      case 'Podcasts':
        icon = AppAssets.podcastIcon;

        break;
      case 'Quotes':
        icon = AppAssets.quotesIcon;
        break;
    }
    return Container(
      padding: const EdgeInsets.only(top: 51),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: widget.resource.thumbnail == ''
              ? const AssetImage(AppAssets.backgroundImage)
              : NetworkImage(widget.resource.thumbnail.fileUrl)
                  as ImageProvider,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              switch (widget.type) {
                case 'Videos':
                  AppNavigation.to(context,
                      VideoPlayerWidget(url: widget.resource.filename.fileUrl));

                  break;
                case 'Books':
                  PdfDialog(url: widget.resource.filename.fileUrl)
                      .show(context);

                  break;
                case 'Audios':
                  AudioPlayerWidget(
                    url: widget.resource.filename,
                    pic: widget.resource.thumbnail,
                    title: widget.resource.title,
                  ).show(context);

                  break;
                case 'Podcasts':
                  AudioPlayerWidget(
                    url: widget.resource.filename,
                    pic: widget.resource.thumbnail,
                    title: widget.resource.title,
                  ).show(context);
                  break;
                case 'Quotes':
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
          ClipRRect(
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
                      GestureDetector(
                        onTap: () async {
                          String sharingText = '';
                          switch (widget.type) {
                            case 'Videos':
                              sharingText = widget.resource.filename.fileUrl;
                              break;
                            case 'Audios':
                              sharingText = widget.resource.filename.fileUrl;
                              break;
                            case 'Books':
                              sharingText = widget.resource.filename.fileUrl;
                              break;
                            case 'Podcasts':
                              sharingText = widget.resource.filename.fileUrl;
                              break;
                          }
                          await Share.share(sharingText);
                        },
                        child: Text(
                          'Share with a Friend',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white,
                          ),
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
                      GestureDetector(
                        onTap: () => like(widget.resource.id),
                        child: Text(
                          widget.resource.liked == true ? 'Unlike' : 'Like',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> like(String id) async {
    try {
      await Awaiter.process(
          future:
              ResourcesApi().likeResource(AppData().readLastUser().userid, id),
          context: context,
          arguments: 'saving');

      widget.resource.liked = !(widget.resource.liked ?? false);
      setState(() {});
    } catch (e) {
      ErrorDialog(error: DioException.withDioError(e));
    }
  }
}
