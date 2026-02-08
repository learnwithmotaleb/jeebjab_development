// simple_alert.dart
import 'package:flutter/material.dart';


import '../../utils/app_colors/app_colors.dart';
import '../core/responsive_layout/dimensions.dart';
import 'app_button.dart';


class SimpleAlert extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String buttonText;
  final Function onButtonPressed;
  final Color color;

  const SimpleAlert({
    Key? key,
    required this.icon,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
    this.color = AppColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16.0),
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: Color(0xffF5F8FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: 40.0,
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10.0),

            // Body/Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColors.hintColor,
              ),
            ),

             SizedBox(height: Dimensions.h(40)),

            // Button
            AppButton(
              width: 250,
                height: 50,
                label: buttonText,
                onPressed: () => onButtonPressed()),
            SizedBox(height: Dimensions.h(40)),
          ],
        ),
      ),
    );
  }
}