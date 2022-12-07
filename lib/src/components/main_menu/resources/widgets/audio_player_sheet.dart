import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe/src/widgets/app_network_image.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget(
      {Key? key, required this.url, required this.title, this.pic})
      : super(key: key);
  final List<String> title;
  final List<String> url;
  final String? pic;

  Future<void> show(BuildContext context) async {
    return await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (_) => this,
    );
  }

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool loading = true;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setAudio(widget.url[selectedIndex]);

    audioPlayer.onPlayerStateChanged.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = event == PlayerState.playing;
        });
      }
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
    audioPlayer.onPlayerComplete.listen((event) {
      selectedIndex++;
      setState(() {});
      if (widget.url.length == selectedIndex) {
        Navigator.pop(context);
        audioPlayer.stop();
        audioPlayer.dispose();
        return;
      } else {
        loading = true;
        setAudio(widget.url[selectedIndex]);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      child: loading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.deepOrange,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: Navigator.of(context).pop,
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(40, 40),
                      shape: const CircleBorder(),
                      backgroundColor: Colors.indigo,
                    ),
                    child: const Icon(
                      Icons.clear,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (widget.pic == null) ...[
                  Container(
                    padding: const EdgeInsets.all(40),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(AppAssets.apple)),
                    ),
                  )
                ] else ...[
                  AppNetworkImage(
                    url: widget.pic!.fileUrl,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ],
                const SizedBox(height: 10),
                Text(
                  widget.title[selectedIndex],
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                ProgressBar(
                  progress: Duration(seconds: position.inSeconds),
                  buffered: const Duration(milliseconds: 2000),
                  total: Duration(seconds: duration.inSeconds),
                  thumbColor: Colors.indigoAccent,
                  progressBarColor: Colors.indigoAccent,
                  baseBarColor: Colors.indigo,
                  onSeek: (duration) async {
                    final position = Duration(seconds: duration.inSeconds);
                    await audioPlayer.seek(position);
                    await audioPlayer.resume();
                    print('User selected a new time: $duration');
                    setState(() {});
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      audioPlayer.resume();
                    }
                  },
                ),
              ],
            ),
    );
  }

  Future<void> setAudio(String url) async {
    print('url ================');
    print(url.fileUrl);
    try {
      await audioPlayer.setReleaseMode(ReleaseMode.release);
      await audioPlayer.setSourceUrl(
        Uri.encodeFull(url.fileUrl),
      );
      if (!mounted) return;
      audioPlayer.resume();
      loading = false;
      setState(() {});
    } catch (e) {
      ErrorDialog(error: DioException.withDioError(e)).show(context);
    }
  }
}
