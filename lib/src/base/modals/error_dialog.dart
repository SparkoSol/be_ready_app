import 'package:be_ready_app/src/services/exception_service.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    required this.error,
  }) : super(key: key);

  final dynamic error;

  @override
  Widget build(BuildContext context) {
    String d = '';
    if (error is DialogError) {
      d = error.description;
    } else {
      d = error.toString();
    }
    return AlertDialog(
      content: Text(d),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('ok'),
        ),
      ],
    );
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}