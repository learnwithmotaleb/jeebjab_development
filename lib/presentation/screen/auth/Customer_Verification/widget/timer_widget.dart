import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../../../../../utils/static_strings/static_strings.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.onResendCode});

  final VoidCallback onResendCode;

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int totalTimeInSeconds;
  Timer? _timer;
  bool showResend = false;

  @override
  void initState() {
    super.initState();
    totalTimeInSeconds = 60;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalTimeInSeconds > 0) {
        setState(() {
          totalTimeInSeconds--;
        });
      } else {
        setState(() {
          showResend = true;
        });
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    setState(() {
      totalTimeInSeconds = 30;
      showResend = false;
    });
    startTimer();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontGetCode.tr,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: showResend
              ? () {
            widget.onResendCode();
            resetTimer();
          }
              : null,
          child: Text(
            showResend
                ? AppStrings.resendCode.tr
                : formatTime(totalTimeInSeconds),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: showResend
                  ? AppColors.primaryColor
                  : AppColors.blackColor
            ),
          ),
        ),
      ],
    );
  }
}
