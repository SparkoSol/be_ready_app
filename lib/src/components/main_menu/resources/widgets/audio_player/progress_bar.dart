import 'package:be_universe/src/components/main_menu/resources/widgets/audio_player/audio_video_progressbar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reusables/reusables.dart';

class ProgressBarController extends ChangeNotifier {
  ProgressBarController({
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;
  var _value = Duration.zero;
  var _max = Duration.zero;
  var _buffered = Duration.zero;

  Duration get value => _value;

  Duration get max => _max;

  Duration get buffered => _buffered;

  void changePosition({
    required Duration value,
    required Duration buffered,
    required Duration max,
  }) {
    _value = value;
    _buffered = buffered;
    _max = max;
    notifyListeners();
  }

  void seek(Duration duration) {
    audioPlayer.seek(duration);
  }
}

class ProgressBarWidget extends ControlledWidget<ProgressBarController> {
  const ProgressBarWidget({
    Key? key,
    required this.barController,
  }) : super(key: key, controller: barController);

  final ProgressBarController barController;

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget>
    with ControlledStateMixin {
  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progress: widget.controller.value,
      total: widget.controller.max,
      buffered: widget.controller.buffered,
      onSeek: widget.controller.seek,
    );
  }
}
