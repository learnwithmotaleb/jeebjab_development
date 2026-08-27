import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/show_map_controller.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class LocationSearchBar extends StatefulWidget {
  final ShowMapController controller;

  const LocationSearchBar({super.key, required this.controller});

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  // Owned + disposed here instead of being recreated on every build().
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    // Keep the field in sync if the controller sets searchText from
    // elsewhere (e.g. clearSearch(), or a future "set text externally" flow)
    // without fighting the user while they're actively typing.
    ever(widget.controller.searchText, (String value) {
      if (_textController.text != value) {
        _textController.value = _textController.value.copyWith(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: "Search location...",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,

                  ),
                  onChanged: controller.onSearchTextChanged,
                ),
              ),
              Obx(() => controller.searchText.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  _textController.clear();
                  controller.clearSearch();
                },
              )
                  : const SizedBox(width: 16)),
            ],
          ),
        ),

        // Autocomplete suggestions
        Obx(() {
          if (controller.isSearching.value) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
                ],
              ),
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          }
          if (controller.predictions.isEmpty) return const SizedBox.shrink();

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints(maxHeight: 280),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: controller.predictions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final prediction = controller.predictions[index];
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.blue),
                  title: Text(
                    prediction.primaryText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    prediction.secondaryText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    // Update the field directly too, so there's no one-frame
                    // flash before the `ever()` listener above catches up.
                    _textController.value = _textController.value.copyWith(
                      text: prediction.fullText,
                      selection: TextSelection.collapsed(offset: prediction.fullText.length),
                    );
                    controller.onPredictionSelected(prediction);
                  },
                );
              },
            ),
          );
        }),
      ],
    );
  }
}