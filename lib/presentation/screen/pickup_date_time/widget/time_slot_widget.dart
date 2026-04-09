import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class TimeSlotsWidget extends StatelessWidget {
  final String dayLabel; // "Today" or "Tomorrow"
  final List<String> slots;
  final String selectedSlotKey; // full key e.g. "today_00:00-01:00"
  final String dayKey; // "today" or "tomorrow"
  final Function(String day, String slot) onSlotTap;

  const TimeSlotsWidget({
    super.key,
    required this.dayLabel,
    required this.slots,
    required this.selectedSlotKey,
    required this.dayKey,
    required this.onSlotTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Dimensions.isTablet;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dayLabel,
          style: TextStyle(
            fontSize: isTablet ? 18 : 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        SizedBox(height: isTablet ? 16 : 10),
        Wrap(
          spacing: isTablet ? 12 : 8,
          runSpacing: isTablet ? 12 : 8,
          children: slots.map((slot) {
            final key = '${dayKey}_$slot';
            final isSelected = selectedSlotKey == key;
            return GestureDetector(
              onTap: () => onSlotTap(dayKey, slot),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 20 : 12, 
                    vertical: isTablet ? 12 : 8
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(isTablet ? 30 : 20),
                  border: isTablet && isSelected
                      ? Border.all(color: Colors.white, width: 2)
                      : null,
                ),
                child: Text(
                  slot,
                  style: TextStyle(
                    fontSize: isTablet ? 15 : 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF555555),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}