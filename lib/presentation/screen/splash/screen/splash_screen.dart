import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _bikeController;
  late AnimationController _shadowController;

  late Animation<double> _logoFade;
  late Animation<Offset> _bikeSlide;
  late Animation<Offset> _shadowSlide;

  @override
  void initState() {
    super.initState();

    // Logo fade-in controller
    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _logoFade = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    // Bike slide from bottom-left to right
    _bikeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _bikeSlide = Tween<Offset>(
      begin: const Offset(-1.6, 0), // start from left
      end: const Offset(4, 0), // final position
    ).animate(CurvedAnimation(parent: _bikeController, curve: Curves.easeOut));

    // Shadow slide from bottom-right to left (under bike)
    _shadowController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _shadowSlide = Tween<Offset>(
      begin: const Offset(1.5, 0), // start from right
      end: const Offset(0, 0), // final position
    ).animate(CurvedAnimation(parent: _shadowController, curve: Curves.easeOut));

    // Start animations
    _logoController.forward();

    // Delay bike and shadow to start slightly after logo
    Future.delayed(const Duration(milliseconds: 400), () {
      _bikeController.forward();
      _shadowController.forward();
    });

    // Navigate to Login Page after 5 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(RoutePath.login); // Replace '/login' with your Login Page route
    });

  }



  @override
  void dispose() {
    _logoController.dispose();
    _bikeController.dispose();
    _shadowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
      desktop: _buildDesktop(),
    );
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          /// Center Logo with Fade-In
          Center(
            child: FadeTransition(
              opacity: _logoFade,
              child: Image.asset(
                AppImages.appLogo,
                width: 200,
                height: 200,

              ),
            ),
          ),

          /// Shadow below the bike, moving from right to left
          Positioned(
            bottom:0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _shadowSlide,
              child: Image.asset(
                AppImages.shadowImage,
                width: double.infinity,

              ),
            ),
          ),

          /// Bike moving from bottom-left to right
          Positioned(
            bottom: 0,
            left: 0,
            child: SlideTransition(
              position: _bikeSlide,
              child: Image.asset(
                AppImages.bike,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tablet Layout
  Widget _buildTablet() {
    return Scaffold(
      body: Center(child: Text("Hello, Tablet")),
    );
  }

  /// Desktop Layout
  Widget _buildDesktop() {
    return Scaffold(
      body: Center(child: Text("Hello, Desktop")),
    );
  }
}
