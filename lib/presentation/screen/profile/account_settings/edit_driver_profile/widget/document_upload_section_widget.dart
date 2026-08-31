import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class DocumentUploadRowData {
  final String label;
  final File? pickedFile;
  final bool alreadyUploaded; // true if the driver already has this doc on file
  final VoidCallback onPick;
  final VoidCallback? onRemove;

  DocumentUploadRowData({
    required this.label,
    required this.pickedFile,
    required this.alreadyUploaded,
    required this.onPick,
    this.onRemove,
  });
}

/// Shows the 3 driver document uploads (driving_license, vehicle_registration,
/// insurance) — each optional; only the ones the driver picks a new file for
/// get sent on update.
class DocumentUploadSection extends StatelessWidget {
  final String sectionTitle;
  final List<DocumentUploadRowData> rows;

  const DocumentUploadSection({
    super.key,
    required this.sectionTitle,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.w(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(Dimensions.r(12)),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: TextStyle(
              fontSize: Dimensions.f(13),
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: Dimensions.h(4)),
          Text(
            "Only pick a file for a document you want to replace.",
            style: TextStyle(
              fontSize: Dimensions.f(11),
              color: AppColors.labelColor.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: Dimensions.h(12)),
          ...rows.map(
            (row) => Padding(
              padding: EdgeInsets.only(bottom: Dimensions.h(10)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          row.label,
                          style: TextStyle(
                            fontSize: Dimensions.f(13),
                            fontWeight: FontWeight.w700,
                            color: AppColors.labelColor,
                          ),
                        ),
                        SizedBox(height: Dimensions.h(2)),
                        Text(
                          row.pickedFile != null
                              ? row.pickedFile!.path
                                    .split(Platform.pathSeparator)
                                    .last
                              : row.alreadyUploaded
                              ? "Uploaded"
                              : "Not uploaded",
                          style: TextStyle(
                            fontSize: Dimensions.f(11),
                            color: row.pickedFile != null
                                ? AppColors.primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (row.pickedFile != null && row.onRemove != null)
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 18),
                      color: Colors.red,
                      onPressed: row.onRemove,
                    ),
                  TextButton.icon(
                    onPressed: row.onPick,
                    icon: const Icon(Icons.upload_file_rounded, size: 16),
                    label: Text(
                      row.pickedFile != null || row.alreadyUploaded
                          ? "Change"
                          : "Upload",
                      style: TextStyle(fontSize: Dimensions.f(12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
