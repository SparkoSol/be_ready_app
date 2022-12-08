import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/components/main_menu/resources/widgets/audio_player/play_pause_button.dart';
import 'package:be_universe/src/components/main_menu/resources/widgets/audio_player/progress_bar.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe/src/widgets/app_network_image.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget(
      {Key? key, required this.title, required this.url, this.pic, this.id})
      : super(key: key);

  final List<String> title;
  final List<String> url;
  final String? pic;
  final String? id;

  Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (_) => this,
    );
  }

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>
    with WidgetsBindingObserver {
  late AudioPlayer _player;
  var _isLoading = true;
  var _error;
  late ProgressBarController _barController;
  late PlayPauseController _playPauseController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  void _init() async {
    _player = AudioPlayer();
    _player.playerStateStream.listen(_audioListener);
    _player.positionStream.listen((position) {
      _barController.changePosition(
        value: position,
        buffered: _barController.buffered,
        max: _barController.max,
      );

      print(position);
      print(_barController.max.runtimeType);
      if (_barController.max != Duration.zero &&
          position == _barController.max) {
        if (_barController.max == Duration.zero) return;

        selectedIndex++;
        setState(() {});
        if (widget.url.length == selectedIndex) {
          Navigator.pop(context);
          _player.stop();
          _player.dispose();
          return;
        }
        _startAudio();
      }
    });
    _player.bufferedPositionStream.listen((event) {
      _barController.changePosition(
        value: _barController.value,
        buffered: event,
        max: _barController.max,
      );
    });

    _player.durationStream.listen((totalDuration) {
      _barController.changePosition(
        value: _barController.value,
        buffered: _barController.buffered,
        max: totalDuration ?? Duration.zero,
      );
    });
    _barController = ProgressBarController(audioPlayer: _player);
    _playPauseController = PlayPauseController(audioPlayer: _player);
    _startAudio();
  }

  Future<void> _startAudio() async {
    if (selectedIndex != 0) {
      _isLoading = true;
      setState(() {});
    }

    try {
      print('${widget.url[selectedIndex].fileUrl}');
      await _player.setUrl(Uri.encodeFull(widget.url[selectedIndex].fileUrl));
      _error = null;
      if (widget.id != null && _error == null) {
        sendProgress();
      }
    } catch (e) {
      if (e is PlayerException) {
        _error = e.message ?? 'Audio file is not available';
      } else {
        _error = 'Audio file is not available';
      }
    }
    _player.play();
    _isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  void _audioListener(PlayerState state) {
    final isPlaying = state.playing;
    final processingState = state.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      _playPauseController.changeState(ButtonState.loading);
    } else if (!isPlaying) {
      _playPauseController.changeState(ButtonState.paused);
    } else if (processingState != ProcessingState.completed) {
      _playPauseController.changeState(ButtonState.playing);
    } else {
      _player.seek(Duration.zero);
      _player.pause();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (_isLoading) {
      child = const Center(
          child: CircularProgressIndicator(
        color: Colors.indigo,
      ));
    } else {
      if (_error != null) {
        child = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              color: Colors.indigo,
              size: 50,
            ),
            Text(
              _error,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      } else {
        child = Column(
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
                      fit: BoxFit.cover, image: AssetImage(AppAssets.apple)),
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
            ProgressBarWidget(barController: _barController),
            PlayPauseWidget(pauseController: _playPauseController),
          ],
        );
      }
    }
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  Future<void> sendProgress() async {
    print('progressing ===========');
    try {
      print(AppData().readLastUser().userid);
      print(widget.id);
      await JourneyApi().sendJourneyProgress(JourneyProgressRequest(
          user: AppData().readLastUser().userid, id: widget.id!));
    } catch (e) {
      print(e);
      ErrorDialog(error: DioException.withDioError(e)).show(context);
    }
  }
}

// class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   Duration buffer = Duration.zero;
//   bool loading = true;
//   int selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     setAudio(widget.url[selectedIndex]);
//
//     audioPlayer.onPlayerStateChanged.listen((event) {
//       if (mounted) {
//         setState(() {
//           isPlaying = event == PlayerState.playing;
//         });
//       }
//     });
//     audioPlayer.onDurationChanged.listen((newDuration) {
//       if (mounted) {
//         setState(() {
//           duration = newDuration;
//         });
//       }
//     });
//     audioPlayer.onPositionChanged.listen((newPosition) {
//       if (mounted) {
//         setState(() {
//           position = newPosition;
//         });
//       }
//     });
//     audioPlayer.onPlayerComplete.listen((event) {
//       selectedIndex++;
//       setState(() {});
//       if (widget.url.length == selectedIndex) {
//         Navigator.pop(context);
//         audioPlayer.stop();
//         audioPlayer.dispose();
//         return;
//       } else {
//         loading = true;
//         setAudio(widget.url[selectedIndex]);
//         setState(() {});
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     // audioPlayer.stop();
//     // audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       padding: const EdgeInsets.all(20),
//       child: loading
//           ? const Center(
//               child: CircularProgressIndicator(
//                 strokeWidth: 3,
//                 color: Colors.deepOrange,
//               ),
//             )
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: Navigator.of(context).pop,
//                     style: TextButton.styleFrom(
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       padding: EdgeInsets.zero,
//                       minimumSize: const Size(40, 40),
//                       shape: const CircleBorder(),
//                       backgroundColor: Colors.indigo,
//                     ),
//                     child: const Icon(
//                       Icons.clear,
//                       size: 20,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 if (widget.pic == null) ...[
//                   Container(
//                     padding: const EdgeInsets.all(40),
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AssetImage(AppAssets.apple)),
//                     ),
//                   )
//                 ] else ...[
//                   AppNetworkImage(
//                     url: widget.pic!.fileUrl,
//                     fit: BoxFit.cover,
//                     width: 80,
//                     height: 80,
//                   ),
//                 ],
//                 const SizedBox(height: 10),
//                 Text(
//                   widget.title[selectedIndex],
//                   style: GoogleFonts.poppins(
//                     fontSize: 15,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ProgressBar(
//                   progress: Duration(seconds: position.inSeconds),
//                   buffered: const Duration(milliseconds: 2000),
//                   total: Duration(seconds: duration.inSeconds),
//                   thumbColor: Colors.indigoAccent,
//                   progressBarColor: Colors.indigoAccent,
//                   baseBarColor: Colors.indigo,
//                   onSeek: (duration) async {
//                     final position = Duration(seconds: duration.inSeconds);
//                     await audioPlayer.seek(position);
//                     await audioPlayer.resume();
//                     print('User selected a new time: $duration');
//                     setState(() {});
//                   },
//                 ),
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.indigo,
//                     shape: const CircleBorder(),
//                     padding: const EdgeInsets.all(10),
//                   ),
//                   child: Icon(
//                     isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                   onPressed: () async {
//                     if (isPlaying) {
//                       await audioPlayer.pause();
//                     } else {
//                       audioPlayer.resume();
//                     }
//                   },
//                 ),
//               ],
//             ),
//     );
//   }
//
//   Future<void> setAudio(String url) async {
//     print('url ================');
//     print(url.fileUrl);
//     try {
//       await audioPlayer.setReleaseMode(ReleaseMode.release);
//       await audioPlayer.setSourceUrl(
//         Uri.encodeFull(url.fileUrl),
//       );
//       if (!mounted) return;
//       audioPlayer.resume();
//       // loading = false;
//       // setState(() {});
//     } catch (e) {
//       print(e);
//       ErrorDialog(error: DioException.withDioError(e)).show(context);
//     }
//   }
// }
