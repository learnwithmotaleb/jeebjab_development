import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dayLabel,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: slots.map((slot) {
            final key = '${dayKey}_$slot';
            final isSelected = selectedSlotKey == key;
            return GestureDetector(
              onTap: () => onSlotTap(dayKey, slot),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  slot,
                  style: TextStyle(
                    fontSize: 12,
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