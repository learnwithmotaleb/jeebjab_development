import 'package:flutter/material.dart';
import 'package:jeebjab/core/enums/post_category_type.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

import '../controller/job_post_controller.dart';

class CategoryToggleRow extends StatelessWidget {
  final List<JobPostCategory> categories;
  final Set<PostCategoryType> selectedCategories;
  final Function(PostCategoryType) onSelect;

  const CategoryToggleRow({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categories.map((cat) {
        final bool isSelected = selectedCategories.contains(cat.type);
        return Padding(
          padding: EdgeInsets.only(right: Dimensions.w(10)),
          child: Tooltip(
            message: cat.label,
            child: GestureDetector(
              onTap: () => onSelect(cat.type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: Dimensions.w(44),
                height: Dimensions.w(44),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.primaryColor
                      : const Color(0xFFE8E8E8),
                ),
                child: Icon(
                  cat.icon,
                  size: Dimensions.w(20),
                  color:
                      isSelected ? Colors.white : const Color(0xFFAAAAAA),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}