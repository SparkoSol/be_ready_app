import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final String arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(strokeWidth: 2),
            const SizedBox(height: 5),
            Text(
              arguments,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  void show(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => this,
    );
  }
}
