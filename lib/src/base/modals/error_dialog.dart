import 'dart:math';

import 'package:be_universe/src/base/theme.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
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
    if (error is DioException) {
      d = error.description;
    } else {
      d = error.toString();
    }
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
        ),
        width: min(280, MediaQuery.of(context).size.width),
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            d,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: Navigator.of(context).pop,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Ok'),
            ),
          ),
        ]),
      ),
    );
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}
