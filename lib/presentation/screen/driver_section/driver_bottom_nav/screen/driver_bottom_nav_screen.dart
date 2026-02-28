import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/presentation/screen/bottom_nav/page/my_post/screen/my_post_screen.dart';
import 'package:jeebjab/presentation/screen/create_post/screen/create_post_screen.dart';
import 'package:jeebjab/presentation/screen/driver_section/driver_bottom_nav/page/driver_home/home/driver_home_screen.dart';
import 'package:jeebjab/presentation/screen/driver_section/driver_bottom_nav/page/task/screen/task_screen.dart';
import 'package:jeebjab/presentation/screen/job/job_post/screen/job_post_screen.dart';
import 'package:jeebjab/presentation/screen/profile/profile/screen/profile_screen.dart';

import '../../../../../utils/app_colors/app_colors.dart';


class DriverBottomNavScreen extends StatefulWidget {
  const DriverBottomNavScreen({super.key});

  @override
  State<DriverBottomNavScreen> createState() => _DriverBottomNavScreenState();
}

class _DriverBottomNavScreenState extends State<DriverBottomNavScreen> {
  int _currentIndex = 0;

  final List<dynamic> _pages = [
    DriverHomeScreen(),
    JobPostScreen(),
    TaskScreen(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobile: _buildMobile());
  }

  Widget _buildMobile() {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greyColor,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            activeIcon: Icon(Icons.work),
            label: "Jobs",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            activeIcon: Icon(Icons.task),
            label: "Task",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
