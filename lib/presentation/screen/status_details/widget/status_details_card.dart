import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class StatusDetailsCard extends StatelessWidget {
  final String name;
  final String phone;
  final String imageUrl;
  final double rating;
  final bool showAcceptButton;
  final bool isMessageEnabled;
  final VoidCallback onMessage;
  final VoidCallback? onAccept;

  const StatusDetailsCard({
    super.key,
    required this.name,
    required this.phone,
    required this.imageUrl,
    required this.rating,
    this.showAcceptButton = false,
    this.isMessageEnabled = true,
    required this.onMessage,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.w(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.r(16)),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.r(12)),
                child: imageUrl.isNotEmpty && imageUrl.startsWith('http')
                    ? Image.network(
                        imageUrl,
                        width: Dimensions.w(50),
                        height: Dimensions.w(50),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildFallbackAvatar(),
                      )
                    : _buildFallbackAvatar(),
              ),
              SizedBox(width: Dimensions.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    Text(
                      phone,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        AppStrings.rating.tr,
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h(16)),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: isMessageEnabled ? onMessage : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00CBA9),
                    disabledBackgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h(12)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.r(10)),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.message.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (showAcceptButton) ...[
                SizedBox(width: Dimensions.w(12)),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00CBA9),
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h(12)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.r(10)),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      AppStrings.accept.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      width: Dimensions.w(50),
      height: Dimensions.w(50),
      color: Colors.grey[100],
      child: const Icon(Icons.person, color: Colors.grey),
    );
  }
}