import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget(
      {Key? key, required this.url, required this.title, required this.pic})
      : super(key: key);
  final String title;
  final String url;
  final String pic;

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
  }

  @override
  void dispose() async {
    await audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      child: Column(
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
          Container(
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/220px-Image_created_with_a_mobile_phone.png',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
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
    );
  }

//'https://beuniverse-api.sparkosol.com/${widget.url}
  Future<void> setAudio() async {
    print('url ================');
    print(widget.url);
    try {
      await audioPlayer.setSourceUrl(
        'http://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3',
      );
      audioPlayer.play;
    } catch (e) {
      print(e);
    }

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
