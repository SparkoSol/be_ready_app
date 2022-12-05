import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
    _customVideoPlayerController.videoPlayerController.play();
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: BackgroundImageWidget(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              videoPlayerController.value.isInitialized
                  ? Center(
                      child: CustomVideoPlayer(
                        customVideoPlayerController:
                            _customVideoPlayerController,
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.deepOrange,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
