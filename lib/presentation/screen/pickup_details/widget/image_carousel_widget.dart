import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class ImageCarouselWidget extends StatefulWidget {
  final List<String> images;

  const ImageCarouselWidget({super.key, required this.images});

  @override
  State<ImageCarouselWidget> createState() => _ImageCarouselWidgetState();
}

class _ImageCarouselWidgetState extends State<ImageCarouselWidget> {
  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return SizedBox(
      height: isTablet ? 500 : 350,
      width: double.infinity,
      child: Stack(
        children: [
          // ── Images ────────────────────────────────────────────────────────
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (i) => _currentPage.value = i,
            itemBuilder: (context, index) {
              return Image.network(
                widget.images[index],
                width: double.infinity,
                height: isTablet ? 500 : 250,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFF0F0F0),
                  child: Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.grey, 
                      size: isTablet ? 80 : 48
                  ),
                ),
              );
            },
          ),

          // ── Dot Indicators ────────────────────────────────────────────────
          Positioned(
            bottom: isTablet ? 24 : 12,
            left: 0,
            right: 0,
            child: Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.images.length, (index) {
                  final isActive = _currentPage.value == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: isActive ? (isTablet ? 30 : 20) : (isTablet ? 10 : 7),
                    height: isTablet ? 10 : 7,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primaryColor
                          : Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}