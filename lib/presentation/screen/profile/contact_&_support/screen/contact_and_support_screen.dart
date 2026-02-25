import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class ContactAndSupportScreen extends StatefulWidget {
  const ContactAndSupportScreen({super.key});

  @override
  State<ContactAndSupportScreen> createState() => _ContactAndSupportScreenState();
}

class _ContactAndSupportScreenState extends State<ContactAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }
  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Column(
              children: [


              ]
          ),
        )
    );
  }
}
