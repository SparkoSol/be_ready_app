import 'dart:async';

import 'package:be_ready_app/src/components/auth/widget/auth_text_span_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
    required this.seconds,
  }) : super(key: key);

  final int seconds;

  @override
  State createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final interval = const Duration(seconds: 1);
  int currentSeconds = 0;

  String get timerText =>
      '${((widget.seconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((widget.seconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  late Timer timer;

  startTimeout() {
    var duration = interval;
    timer = Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= widget.seconds) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return timer.isActive
        ? AuthTextSpanWidget(
            buttonTitle: timerText,
            action: () {},
            message: 'Re-send code in ',
          )
        : GestureDetector(
            child: Text(
              'Re-send Code',
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            onTap: () => startTimeout(),
          );
  }
}
