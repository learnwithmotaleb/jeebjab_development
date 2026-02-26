import 'package:flutter/material.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';
import 'package:jeebjab/utils/app_colors/app_colors.dart';

class SortDropdown extends StatefulWidget {
  final String selected;
  final List<String> options;
  final Function(String) onSelect;

  const SortDropdown({
    super.key,
    required this.selected,
    required this.options,
    required this.onSelect,
  });

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggle() {
    if (_isOpen) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    final overlay = Overlay.of(context);
    _overlayEntry = _buildOverlay();
    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  void _select(String opt) {
    widget.onSelect(opt);
    _close();
  }

  OverlayEntry _buildOverlay() {
    return OverlayEntry(
      builder: (context) => GestureDetector(
        // tap outside to close
        onTap: _close,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            // ── Dropdown positioned below the button ──────────────────
            Positioned(
              width: 100,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, Dimensions.h(44)), // below button
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.r(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.options.map((opt) {
                        final bool isSelected = widget.selected == opt;
                        return GestureDetector(
                          onTap: () => _select(opt),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w(16),
                              vertical: Dimensions.h(5),
                            ),
                            child: Text(
                              opt,
                              style: TextStyle(
                                fontSize: Dimensions.f(14),
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.labelColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggle,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w(12),
            vertical: Dimensions.h(8),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.r(20)),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.selected,
                style: TextStyle(
                  fontSize: Dimensions.f(13),
                  fontWeight: FontWeight.w500,
                  color: AppColors.labelColor,
                ),
              ),
              SizedBox(width: Dimensions.w(4)),
              Icon(
                _isOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: Dimensions.w(18),
                color: AppColors.labelColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}