import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({Key? key, required this.url, required this.title})
      : super(key: key);
  final String title;
  final String url;

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
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String audioasset = "assets/audio/red-indian-music.mp3";
  bool isplaying = false;
  bool audioplayed = false;
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {});
      });

      player.onPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();

    return Container(
      height: 300,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.title,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            Text(
              currentpostlabel,
              style: const TextStyle(fontSize: 25),
            ),
            Slider(
              value: double.parse(currentpos.toString()),
              min: 0,
              max: double.parse(maxduration.toString()),
              divisions: maxduration,
              label: currentpostlabel,
              onChanged: (double value) async {
                int seekval = value.round();
                // int result = await player.seek(Duration(milliseconds: seekval));
                //
                // if (result == 1) { //seek successful
                //   currentpos = seekval;
                // } else {
                //   print("Seek unsuccessful.");
                // }
              },
            ),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      if (!isplaying && !audioplayed) {
                        await player.setSourceUrl(widget.url);
                        player.play;
                        setState(() {
                          isplaying = true;
                          audioplayed = true;
                        });
                      } else if (audioplayed && !isplaying) {
                        await player.resume();

                        setState(() {
                          isplaying = true;
                          audioplayed = true;
                        });
                      } else {
                        await player.pause();
                        //pause success
                        setState(() {
                          isplaying = false;
                        });
                      }
                    },
                    icon: Icon(isplaying ? Icons.pause : Icons.play_arrow),
                    label: Text(isplaying ? "Pause" : "Play")),
                ElevatedButton.icon(
                    onPressed: () async {
                      await player.stop();

                      setState(() {
                        isplaying = false;
                        audioplayed = false;
                        currentpos = 0;
                      });
                    },
                    icon: const Icon(Icons.stop),
                    label: const Text("Stop")),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
