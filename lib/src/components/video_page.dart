import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:be_ready_app/src/widgets/video_widget.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
          child: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: 55,
            right: 55,
            bottom: 20,
            top: MediaQuery.of(context).viewPadding.top + 56),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoalsPageTitle(text: 'Videos'),

            SizedBox(height: 20,),
            for (int i = 0; i < 10; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: VideoWidget(path: AppAssets.backgroundImage),
              )
          ],
        ),
      )),
    );
  }
}
