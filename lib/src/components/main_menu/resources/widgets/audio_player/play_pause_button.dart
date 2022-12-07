import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reusables/reusables.dart';

enum ButtonState {
  loading,
  playing,
  paused,
}

class PlayPauseController extends ChangeNotifier {
  PlayPauseController({
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  var _state = ButtonState.loading;

  void changeState(ButtonState state) {
    _state = state;
    notifyListeners();
  }
}

class PlayPauseWidget extends ControlledWidget<PlayPauseController> {
  const PlayPauseWidget({
    Key? key,
    required this.pauseController,
  }) : super(key: key, controller: pauseController);

  final PlayPauseController pauseController;

  @override
  State<PlayPauseWidget> createState() => _PlayPauseWidgetState();
}

class _PlayPauseWidgetState extends State<PlayPauseWidget>
    with ControlledStateMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.controller._state == ButtonState.loading) {
      return const CircularProgressIndicator(
        color: Colors.indigo,
      );
    }
    late IconData icon;
    var isPlaying = false;
    switch (widget.controller._state) {
      case ButtonState.loading:
        break;
      case ButtonState.playing:
        icon = Icons.pause;
        isPlaying = true;
        break;
      case ButtonState.paused:
        isPlaying = false;
        icon = Icons.play_arrow;
        break;
    }
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        minimumSize: const Size(40, 40),
        shape: const CircleBorder(),
        backgroundColor: Colors.indigo,
      ),
      onPressed: () async {
        if (isPlaying) {
          widget.controller.audioPlayer.pause();
          widget.controller.changeState(ButtonState.paused);
        } else {
          widget.controller.audioPlayer.play();
          widget.controller.changeState(ButtonState.playing);
        }
      },
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
