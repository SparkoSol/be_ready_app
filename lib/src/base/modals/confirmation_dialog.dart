import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationDialog extends StatelessWidget {
  ConfirmationDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  var fontStyle = GoogleFonts.poppins(color: Colors.indigo);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentTextStyle: const TextStyle(color: Colors.black),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'Yes',
            style: fontStyle,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'No',
            style: fontStyle,
          ),
        ),
      ],
    );
  }

  Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => this,
        ) ??
        false;
  }
}
