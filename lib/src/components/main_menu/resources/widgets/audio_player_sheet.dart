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
  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();

    return Container(
      height: 200,
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
            const SizedBox(
              height: 5,
            ),
            TextButton.icon(
                onPressed: () async {
                  await player.setSourceUrl(widget.url);
                },
                icon: Icon(Icons.play_arrow),
                label: Text('play'))
          ],
        ),
      ),
    );
  }
}
