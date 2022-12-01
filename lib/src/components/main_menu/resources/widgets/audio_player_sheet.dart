import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget(
      {Key? key, required this.url, required this.title, required this.pic})
      : super(key: key);
  final String title;
  final String url;
  final String pic;

  Future<void> show(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (_) => this,
    );
  }

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  // int maxDuration = 100;
  // int currentPos = 0;
  // String currentPostLabel = "00:00";
  // String audioAsset = "assets/audio/red-indian-music.mp3";
  // bool isPlaying = false;
  // bool audioPlayed = false;
  // AudioPlayer player = AudioPlayer();
  //
  // @override
  // void initState() {
  //   player.onDurationChanged.listen((Duration d) {
  //     maxDuration = d.inMilliseconds;
  //     setState(() {});
  //   });
  //   player.onPositionChanged.listen((Duration p) {
  //     currentPos = p.inMilliseconds;
  //     int shours = Duration(milliseconds: currentPos).inHours;
  //     int sminutes = Duration(milliseconds: currentPos).inMinutes;
  //     int sseconds = Duration(milliseconds: currentPos).inSeconds;
  //
  //     int rhours = shours;
  //     int rminutes = sminutes - (shours * 60);
  //     int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);
  //     currentPostLabel = "$rhours:$rminutes:$rseconds";
  //
  //     setState(() {});
  //   });
  //
  //   super.initState();
  // }
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setAudio());

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.indigo,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      height: 300,
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            CircleAvatar(
              child: Image.network(widget.pic,
                  width: 100, height: 100, fit: BoxFit.cover),
            ),
            ProgressBar(
              progress: Duration(seconds: duration.inSeconds),
              buffered: const Duration(milliseconds: 2000),
              total: Duration(seconds: position.inSeconds),
              onSeek: (duration) async {
                final position = Duration(seconds: duration.inSeconds);
                await audioPlayer.seek(position);
                await audioPlayer.resume();
                print('User selected a new time: $duration');
              },
            ),
            CircleAvatar(
                radius: 35,
                child: IconButton(
                    onPressed: () async {
                      print('isplaying $isPlaying');
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        audioPlayer.resume();
                      }
                    },
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow)))
            // Container(
            //   decoration: const BoxDecoration(
            //       color: Colors.white,
            //       shape: BoxShape.rectangle,
            //       borderRadius: BorderRadius.all(Radius.circular(16))),
            //   padding: const EdgeInsets.all(10),
            //   child: Text(
            //     widget.title,
            //     style: GoogleFonts.poppins(color: Colors.white),
            //   ),
            // ),
            // Text(
            //   currentPostLabel,
            //   style: const TextStyle(fontSize: 25),
            // ),
            // ProgressBar(
            //   progress: Duration(seconds: currentPos),
            //   buffered: const Duration(milliseconds: 2000),
            //   total: Duration(seconds: maxDuration),
            //   onSeek: (duration) {
            //     currentPos = duration.inSeconds;
            //     print('User selected a new time: $duration');
            //   },
            // ),
            // Slider(
            //   value: double.parse(currentpos.toString()),
            //   min: 0,
            //   max: double.parse(maxduration.toString()),
            //   divisions: maxduration,
            //   label: currentpostlabel,
            //   onChanged: (double value) async {
            //     int seekval = value.round();
            //     // int result = await player.seek(Duration(milliseconds: seekval));
            //     //
            //     // if (result == 1) { //seek successful
            //     //   currentpos = seekval;
            //     // } else {
            //     //   print("Seek unsuccessful.");
            //     // }
            //   },
            // ),
            // Wrap(
            //   spacing: 10,
            //   children: [
            //     ElevatedButton.icon(
            //         onPressed: () async {
            //           if (!isPlaying && !audioPlayed) {
            //             player.play;
            //             setState(() {
            //               isPlaying = true;
            //               audioPlayed = true;
            //             });
            //           } else if (audioPlayed && !isPlaying) {
            //             await player.resume();
            //             setState(() {
            //               isPlaying = true;
            //               audioPlayed = true;
            //             });
            //           } else {
            //             await player.pause();
            //             setState(() {
            //               isPlaying = false;
            //             });
            //           }
            //         },
            //         icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            //         label: Text(isPlaying ? "Pause" : "Play")),
            //     ElevatedButton.icon(
            //         onPressed: () async {
            //           await player.stop();
            //
            //           setState(() {
            //             isPlaying = false;
            //             audioPlayed = false;
            //             currentPos = 0;
            //           });
            //         },
            //         icon: const Icon(Icons.stop),
            //         label: const Text("Stop")),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    print('url ================');
    print(widget.url);
    await audioPlayer.setSourceUrl(
      widget.url,
    );
    audioPlayer.play;
    print('player state');
    print(audioPlayer.state);
  }
}

// class AudioPlaying extends StatefulWidget {
//   const AudioPlaying({Key? key, required this.url, required this.pic})
//       : super(key: key);
//   final String url;
//   final String pic;
//
//   @override
//   State<AudioPlaying> createState() => _AudioPlayingState();
// }
//
// class _AudioPlayingState extends State<AudioPlaying> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [],
//         ),
//       ),
//     );
//   }
// }
