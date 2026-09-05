import 'package:flutter/material.dart';
import 'package:jeebjab/service/google_places_service.dart';

/// Dropdown-style list of Google Places Autocomplete suggestions, shown
/// right under an address text field while the user is typing.
class AddressPredictionsList extends StatelessWidget {
  final List<AutocompletePrediction> predictions;
  final ValueChanged<AutocompletePrediction> onSelect;

  const AddressPredictionsList({
    super.key,
    required this.predictions,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (predictions.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: predictions.length,
        separatorBuilder: (_, _) =>
            const Divider(height: 1, color: Color(0xFFF0F0F0)),
        itemBuilder: (context, index) {
          final prediction = predictions[index];
          return ListTile(
            dense: true,
            leading: const Icon(Icons.location_on_outlined,
                size: 20, color: Colors.grey),
            title: Text(
              prediction.primaryText,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            subtitle: prediction.secondaryText.isNotEmpty
                ? Text(
                    prediction.secondaryText,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  )
                : null,
            onTap: () => onSelect(prediction),
          );
        },
      ),
    );
  }
}
