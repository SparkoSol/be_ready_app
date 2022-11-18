import 'package:be_ready_app/src/components/auth/widget/auth_button_title_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_text_span_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/timed_widget.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/app_text_field.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // String? _codeEntered;

  final _digit1 = FocusNode();
  final _digit2 = FocusNode();
  final _digit3 = FocusNode();
  final _digit4 = FocusNode();

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  final _timerController = TimedWidgetController();

  @override
  void initState() {
    _timerController.start(
      const Duration(seconds: 1),
      const Duration(seconds: 1200),
    );
    super.initState();
  }

  bool _isCodeValid(List<String> digits) {
    return digits.fold(true, (v, e) => v && e.isNotEmpty && e != ' ');
  }

  ValueChanged<String?> _digitInputHandler(
    FocusNode? prev,
    FocusNode current,
    FocusNode? next,
  ) {
    print('Handling');
    return (String? val) {
      print('Handling Inner');
      if (val != null && val.isNotEmpty) {
        if (_isCodeValid([
          _controller1.text,
          _controller2.text,
          _controller3.text,
          _controller4.text,
        ])) {
          // widget.controller.canVerify = true;
        }

        if (next == null) {
          // _codeEntered = _controller1.text +
          //     _controller2.text +
          //     _controller3.text +
          //     _controller4.text;
          current.unfocus();
        } else {
          next.requestFocus();
        }
      } else {
        // widget.controller.canVerify = false;
        prev?.requestFocus();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.padding;
    final width = mediaQuery.size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: padding.top + 56,
            bottom: padding.bottom,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(33, 22, 33, 28),
            child: Column(
              children: [
                const AuthTitleWidget(title: 'Verification'),
                Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'We’ve sent you a verification code to your email',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _OtpFieldBorder(
                      isFocused: _digit1.hasFocus,
                      child: AppTextField(
                        bottomPadding: 0,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => _digitInputHandler(
                          null,
                          _digit1,
                          _digit2,
                        ),
                        focusNode: _digit1,
                        textEditingController: _controller1,
                        textAlign: TextAlign.center,
                        hintColor: Colors.white,
                        maxLength: 1,
                        hint: '-',
                      ),
                    ),
                    _OtpFieldBorder(
                      isFocused: _digit2.hasFocus,
                      child: AppTextField(
                        bottomPadding: 0,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => _digitInputHandler(
                          _digit1,
                          _digit2,
                          _digit3,
                        ),
                        focusNode: _digit2,
                        hint: '-',
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        hintColor: Colors.white,
                        textEditingController: _controller2,
                      ),
                    ),
                    _OtpFieldBorder(
                      isFocused: _digit3.hasFocus,
                      child: AppTextField(
                        bottomPadding: 0,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => _digitInputHandler(
                          _digit2,
                          _digit3,
                          _digit4,
                        ),
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        hint: '-',
                        focusNode: _digit3,
                        hintColor: Colors.white,
                        textEditingController: _controller3,
                      ),
                    ),
                    _OtpFieldBorder(
                      isFocused: _digit4.hasFocus,
                      child: AppTextField(
                        bottomPadding: 0,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => _digitInputHandler(
                          _digit3,
                          _digit4,
                          null,
                        ),
                        hintColor: Colors.white,
                        maxLength: 1,
                        hint: '-',
                        focusNode: _digit4,
                        textAlign: TextAlign.center,
                        textEditingController: _controller4,
                      ),
                    ),
                  ],
                ),
                AppButtonWidget(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: const AuthButtonTitleWidget(title: 'CONTINUE'),
                ),
                const SizedBox(height: 28),
                TimedWidget(
                  builder: (_, time) {
                    return AuthTextSpanWidget(
                      buttonTitle: _formatTime(time.inSeconds),
                      action: () {},
                      message: 'Re-send code in ',
                    );
                  },
                  controller: _timerController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    var minutes = seconds ~/ 60;
    var secondsStr = (seconds % 60).toString();

    if (secondsStr.length == 1) secondsStr = '0$secondsStr';
    return '$minutes:$secondsStr';
  }
}

class _OtpFieldBorder extends StatefulWidget {
  const _OtpFieldBorder({
    Key? key,
    required this.child,
    required this.isFocused,
  }) : super(key: key);

  final bool isFocused;
  final Widget child;

  @override
  State<_OtpFieldBorder> createState() => _OtpFieldBorderState();
}

class _OtpFieldBorderState extends State<_OtpFieldBorder> {
  late bool _isFocused;

  @override
  void initState() {
    _isFocused = widget.isFocused;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _OtpFieldBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isFocused = widget.isFocused;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: _isFocused
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7491D4),
                  Color(0xFFDFDFA3),
                ],
              )
            : null,
      ),
      child: widget.child,
    );
  }
}
