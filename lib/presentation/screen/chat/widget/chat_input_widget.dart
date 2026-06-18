import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/presentation/screen/chat/controller/chat_controller.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/app_bottom_sheet.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final ChatController controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // ✅ CHECK IF STATUS IS NOT DELIVERED (can message)
      bool canMessage = controller.deliveryStatus.value != 'delivered';

      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w(16),
          vertical: Dimensions.h(12),
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border(
            top: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
        ),
        child: canMessage ? _buildActiveInputBar() : _buildDisabledInputBar(),
      );
    });
  }

  // ✅ ENABLED INPUT FIELD (when delivered)
  Widget _buildActiveInputBar() {
    return Row(
      children: [
        // File/Image Upload Button
        GestureDetector(
          onTap: () => _showAttachmentBottomSheet(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            padding: EdgeInsets.all(Dimensions.w(12)),
            child: Icon(
              Icons.attach_file_rounded,
              color: AppColors.primaryColor,
              size: Dimensions.f(20),
            ),
          ),
        ),
        SizedBox(width: Dimensions.w(12)),

        // Message Input Field
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(Dimensions.r(24)),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: AppStrings.writeMessage.tr,
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: Dimensions.f(14),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w(16),
                  vertical: Dimensions.h(12),
                ),


              ),
              style: TextStyle(
                fontSize: Dimensions.f(14),
                color: Colors.black,
              ),
              maxLines: null,
              minLines: 1,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => controller.sendMessage(),
            ),
          ),
        ),
        SizedBox(width: Dimensions.w(12)),

        // Send Button
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.send_rounded,
              color: Colors.white,
              size: Dimensions.f(20),
            ),
            onPressed: controller.sendMessage,
            padding: EdgeInsets.all(Dimensions.w(12)),
            splashRadius: Dimensions.r(24),
          ),
        ),
      ],
    );
  }

  // ✅ DISABLED MESSAGE (when DELIVERED - cannot message)
  Widget _buildDisabledInputBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w(16),
        vertical: Dimensions.h(16),
      ),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Dimensions.r(12)),
        border: Border.all(
          color: Colors.amber.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.amber[700],
            size: Dimensions.f(20),
          ),
          SizedBox(width: Dimensions.w(12)),
          Expanded(
            child: Text(
              'You cannot send messages after delivery',
              style: TextStyle(
                fontSize: Dimensions.f(13),
                color: Colors.amber[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAttachmentBottomSheet(BuildContext context) {
    AppBottomSheet(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.w(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Source",
              style: TextStyle(
                fontSize: Dimensions.f(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Dimensions.h(16)),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(Dimensions.w(8)),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.camera_alt_rounded, color: AppColors.primaryColor),
              ),
              title: Text("Camera"),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(Dimensions.w(8)),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.photo_library_rounded, color: AppColors.primaryColor),
              ),
              title: Text("Gallery"),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}