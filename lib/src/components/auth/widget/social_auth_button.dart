import 'package:be_universe/src/base/modals/error_dialog.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialAuthButton extends StatefulWidget {
  const SocialAuthButton({
    Key? key,
    required this.onTap,
    required this.platformImage,
    required this.platformName,
    this.after,
    this.before,
  }) : super(key: key);

  final String platformImage;
  final String platformName;
  final Future<void> Function() onTap;
  final VoidCallback? before;
  final VoidCallback? after;

  @override
  State<SocialAuthButton> createState() => _SocialAuthButtonState();
}

class _SocialAuthButtonState extends State<SocialAuthButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (_isLoading) {
      child = Center(
        child: CircularProgressIndicator(
          color: Colors.deepOrangeAccent.withOpacity(0.5),
          strokeWidth: 3,
        ),
      );
    } else {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(widget.platformImage),
          const SizedBox(width: 22),
          Text(
            'Login with ${widget.platformName}',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ],
      );
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
        boxShadow: const [
          BoxShadow(
            offset: Offset(15, 0),
            blurRadius: 30,
            spreadRadius: 0,
            color: Color.fromRGBO(211, 212, 226, 0.25),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // backgroundColor: const Color.fromRGBO(255, 255, 255, 0.05),
          // backgroundColor: Colors.white.withOpacity(0.5),
          backgroundColor: Colors.transparent,
          minimumSize: const Size.fromHeight(66),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _isLoading
            ? null
            : () async {
                _isLoading = true;
                setState(() {});
                try {
                  if (widget.before != null) {
                    widget.before!();
                  }
                  await widget.onTap();
                } catch (e) {
                  if (!mounted) return;
                  ErrorDialog(error: DioException.withDioError(e))
                      .show(context);
                }
                if (!mounted) return;
                if (widget.after != null) {
                  widget.after!();
                }
                _isLoading = false;
                setState(() {});
              },
        child: child,
      ),
    );
  }
}
