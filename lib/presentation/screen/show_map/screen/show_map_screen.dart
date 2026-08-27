import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../controller/show_map_controller.dart';
import '../widget/location_search_bar.dart';
import '../widget/location_bottom_card.dart';

class ShowMapScreen extends StatefulWidget {
  const ShowMapScreen({super.key});

  @override
  State<ShowMapScreen> createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  final ShowMapController controller = Get.put(ShowMapController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),
    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Map
          Obx(() => GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: controller.initialCameraPosition,
            onMapCreated: controller.onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onTap: (LatLng latLng) {
              controller.updateMarkerPosition(latLng);
              controller.moveToLocation(latLng);
            },
            markers: {
              Marker(
                markerId: const MarkerId('selected-location'),
                position: controller.selectedPosition.value,
                draggable: true,
                onDragEnd: (LatLng newPosition) {
                  controller.updateMarkerPosition(newPosition);
                },
              ),
            },
            // Keep zoom/compass/my-location controls clear of the
            // bottom card instead of letting them sit underneath it.
            padding: const EdgeInsets.only(bottom: 260),
          )),

          // Back button + search bar — now inside SafeArea so they never
          // sit under a notch / status bar / dynamic island.
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 16),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: LocationSearchBar(controller: controller),
                  ),
                ],
              ),
            ),
          ),

          // Current Location FAB
          Positioned(
            right: 16,
            bottom: 260, // sits just above the bottom card
            child: FloatingActionButton(
              backgroundColor: AppColors.whiteColor,
              onPressed: controller.moveToCurrentLocation,
              child: Obx(() => controller.isLoadingLocation.value
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.my_location, color: Colors.blue)),
            ),
          ),

          // Bottom Card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: LocationBottomCard(controller: controller),
          ),
        ],
      ),
    );
  }
}