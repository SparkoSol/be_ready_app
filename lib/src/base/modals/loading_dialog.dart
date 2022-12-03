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
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
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
