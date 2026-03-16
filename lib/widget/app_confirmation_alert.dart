import 'package:flutter/material.dart';

class AppSuccessAlert {
  static void show({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false, // user cannot dismiss by tapping outside
      builder: (dialogContext) {
        // Automatically pop after 5 seconds
        Future.delayed(const Duration(seconds: 1), () {
          if (Navigator.canPop(dialogContext)) {
            Navigator.of(dialogContext).pop();
          }
        });

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Success Icon
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.teal,
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.teal,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),

                /// Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                /// OK Button (optional, still allows manual dismiss)
                // ElevatedButton(
                //   onPressed: () {
                //     if (Navigator.canPop(dialogContext)) {
                //       Navigator.of(dialogContext).pop();
                //     }
                //   },
                //   child: const Text("OK"),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
