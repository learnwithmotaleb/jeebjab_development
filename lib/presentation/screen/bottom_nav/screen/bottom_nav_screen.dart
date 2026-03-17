import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jeebjab/core/responsive_layout/responsive_layout.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/presentation/screen/bottom_nav/page/my_post/screen/my_post_screen.dart';
import 'package:jeebjab/presentation/screen/create_post/screen/create_post_screen.dart';
import 'package:jeebjab/presentation/screen/job/customer_job_post/screen/customer_job_post_screen.dart';
import 'package:jeebjab/presentation/screen/job/job_post/screen/job_post_screen.dart';
import 'package:jeebjab/presentation/screen/profile/profile/screen/profile_screen.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../core/enums/app_role.dart';
import '../../../../helper/local_db/local_db.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../page/home/screen/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  // motaleb islla
  List<Widget> get _pages => [
    const HomeScreen(),
    _getJobPage(),
    CreatePostScreen(),
    const MyPostScreen(),
    const ProfileScreen(),
  ];

  Widget _getJobPage() {
    final role = SharePrefsHelper.getRole();
    if (role == AppRole.CUSTOMER) {
      return CustomerJobPostScreen();
    } else if (role == AppRole.DRIVER) {
      return const JobPostScreen();
    } else {
      return const JobPostScreen();
    }
  }



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
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: AppStrings.home.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.work_outline),
            activeIcon: const Icon(Icons.work),
            label: AppStrings.jobs.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_circle_outline),
            activeIcon: const Icon(Icons.add),
            label: AppStrings.create.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.article_outlined),
            activeIcon: const Icon(Icons.article),
            label: AppStrings.myPost.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: AppStrings.profile.tr,
          ),
        ],
      ),
    );
  }
}