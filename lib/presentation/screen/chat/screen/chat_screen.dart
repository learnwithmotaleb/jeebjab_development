import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/presentation/screen/chat/controller/chat_controller.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';

import '../../../../core/responsive_layout/dimensions.dart';
import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../widget/chat_input_widget.dart';
import '../widget/chat_message_buble_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
      tablet: _buildTablet(),
    );
  }

  /// Tablet Layout
  Widget _buildTablet() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _buildAppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: _buildChatBody(),
        ),
      ),
    );
  }

  /// Mobile Layout
  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _buildAppBar(),
      body: _buildChatBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      leadingWidth: Dimensions.w(80),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: Dimensions.f(20)),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.r(2)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor.withOpacity(0.2), width: 1.5),
            ),
            child: CircleAvatar(
              radius: Dimensions.r(18),
              backgroundImage: AssetImage(AppImages.profileImage),
            ),
          ),
          SizedBox(width: Dimensions.w(12)),
          Text(
            "Abdul Motaleb",
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.f(18),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: Colors.grey[100], thickness: 1),
      ),
    );
  }

  Widget _buildChatBody() {
    return Column(
      children: [
        // Chat Messages List
        Expanded(
          child: Obx(() => ListView.builder(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w(16), vertical: Dimensions.h(20)),
            itemCount: controller.messages.length,
            itemBuilder: (context, index) {
              final message = controller.messages[index];
              return ChatMessageBubble(message: message);
            },
          )),
        ),

        // Bottom Input Bar
        const ChatInputBar(),
      ],
    );
  }
}