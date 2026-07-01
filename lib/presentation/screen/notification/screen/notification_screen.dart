import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../widget/custom_appbar.dart';
import '../controller/notification_controller.dart';
import '../widget/notification_card_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
      if (controller.isMoreDataAvailable && !controller.isLoadMore) {
        controller.getNotificationRequest(isLoadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.notification.tr,
        actions: _buildAppBarActions(),
      ),
      body: Obx(() {
        if (controller.isLoadingNotificationList.value && controller.localNotificationList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.localNotificationList.isEmpty) {
          return _buildEmptyState();
        }
        return RefreshIndicator(
          onRefresh: () async {
            await controller.getNotificationRequest();
          },
          color: AppColors.primaryColor,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: _buildNotificationContent(),
          ),
        );
      }),
    );
  }

  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: AppStrings.notification.tr,
        actions: _buildAppBarActions(),
      ),
      body: Obx(() {
        if (controller.isLoadingNotificationList.value && controller.localNotificationList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.localNotificationList.isEmpty) {
          return _buildEmptyState();
        }
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.getNotificationRequest();
              },
              color: AppColors.primaryColor,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w(24),
                  vertical: Dimensions.h(20),
                ),
                child: _buildNotificationContent(),
              ),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        icon: const Icon(
          Icons.delete_sweep_outlined,
          color: Colors.redAccent,
        ),
        tooltip: 'Clear All',
        onPressed: () {
          if (controller.localNotificationList.isEmpty) return;
          Get.defaultDialog(
            title: 'Clear All'.tr,
            middleText: 'Are you sure you want to delete all notifications?'.tr,
            textConfirm: 'Yes'.tr,
            textCancel: 'Cancel'.tr,
            confirmTextColor: Colors.white,
            buttonColor: AppColors.primaryColor,
            onConfirm: () {
              controller.clearAllLocalNotifications();
              Get.back();
            },
          );
        },
      ),
    ];
  }

  Widget _buildNotificationContent() {
    final now = DateTime.now();
    final recent = <Map<String, dynamic>>[];
    final previous = <Map<String, dynamic>>[];

    for (var item in controller.localNotificationList) {
      final dateStr = item['createdAt'];
      if (dateStr != null) {
        try {
          final date = DateTime.parse(dateStr);
          if (now.difference(date).inHours < 24) {
            recent.add(item);
          } else {
            previous.add(item);
          }
        } catch (_) {
          recent.add(item);
        }
      } else {
        recent.add(item);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (recent.isNotEmpty) ...[
          SizedBox(height: Dimensions.h(10)),
          _buildSectionHeader(AppStrings.recent.tr),
          SizedBox(height: Dimensions.h(5)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recent.length,
            itemBuilder: (context, index) {
              final item = recent[index];
              return _buildDismissibleCard(item);
            },
          ),
        ],
        if (previous.isNotEmpty) ...[
          SizedBox(height: Dimensions.h(16)),
          _buildSectionHeader(AppStrings.previous.tr),
          SizedBox(height: Dimensions.h(5)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: previous.length,
            itemBuilder: (context, index) {
              final item = previous[index];
              return _buildDismissibleCard(item);
            },
          ),
        ],
        SizedBox(height: Dimensions.h(20)),
        if (controller.isLoadMore)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildDismissibleCard(Map<String, dynamic> item) {
    final id = item['_id'] ?? '';
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.w(16),
          vertical: Dimensions.h(8),
        ),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.9),
          borderRadius: BorderRadius.circular(Dimensions.r(16)),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(20)),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        controller.deleteNotification(id);
      },
      child: NotificationCard(
        imagePath: item['imagePath'] ?? '',
        title: item['title'] ?? 'Notification',
        subtitle: item['subtitle'] ?? '',
        message: item['message'] ?? '',
        timeAgo: _formatTimeAgo(item['createdAt']),
        isRead: item['isRead'] ?? true,
        onTap: () {
          controller.markAsRead(id);
          // Standard action: route to statusDetails page
          Get.toNamed(RoutePath.statusDetails);
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: Dimensions.f(18),
          fontWeight: FontWeight.w700,
          color: AppColors.blackColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w(32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.h(100)),
            Container(
              padding: EdgeInsets.all(Dimensions.w(24)),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: Dimensions.w(64),
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: Dimensions.h(24)),
            Text(
              'No Notifications yet'.tr,
              style: TextStyle(
                fontSize: Dimensions.f(20),
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: Dimensions.h(8)),
            Text(
              'When you receive updates and alerts, they will appear here.'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.f(14),
                color: AppColors.greyColor,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(isoString);
      final difference = DateTime.now().difference(dateTime);

      if (difference.inSeconds < 60) {
        return 'Just now'.tr;
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago'.tr;
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago'.tr;
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago'.tr;
      } else {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
    } catch (_) {
      return '';
    }
  }
}
