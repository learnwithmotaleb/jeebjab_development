import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jeebjab/core/responsive_layout/dimensions.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../controller/route_map_controller.dart';
import '../widget/route_info_card.dart';

/// Shows a job's pickup → drop-off route: both markers, the driving
/// polyline between them, and the distance/duration. Reached from the
/// "Open Map" / "Live Tracking" buttons on Post Details, Status Details,
/// and Task Details.
class RouteMapScreen extends StatefulWidget {
  const RouteMapScreen({super.key});

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  final RouteMapController controller = Get.put(RouteMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(() {
        if (controller.errorMessage.value.isNotEmpty &&
            controller.routePoints.isEmpty) {
          return _buildError(controller.errorMessage.value);
        }

        return Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: controller.initialCameraPosition,
              onMapCreated: controller.onMapCreated,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: {
                Marker(
                  markerId: const MarkerId('pickup'),
                  position: controller.pickupPosition,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  infoWindow: InfoWindow(
                    title: 'Pick-Up',
                    snippet: controller.pickupAddress.value,
                  ),
                ),
                if (controller.hasDropoff)
                  Marker(
                    markerId: const MarkerId('dropoff'),
                    position: controller.dropoffPosition!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                    infoWindow: InfoWindow(
                      title: 'Drop-Off',
                      snippet: controller.dropoffAddress.value,
                    ),
                  ),
                if (controller.myLocation.value != null)
                  Marker(
                    markerId: const MarkerId('my_location'),
                    position: controller.myLocation.value!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure),
                    infoWindow: const InfoWindow(title: 'You are here'),
                  ),
              },
              polylines: {
                if (controller.routePoints.length > 1)
                  Polyline(
                    polylineId: const PolylineId('route'),
                    points: controller.routePoints,
                    color: AppColors.primaryColor,
                    width: 5,
                  ),
                if (controller.myLocationRoutePoints.length > 1)
                  Polyline(
                    polylineId: const PolylineId('my_location_route'),
                    points: controller.myLocationRoutePoints,
                    color: Colors.blueAccent,
                    width: 4,
                    patterns: [PatternItem.dash(12), PatternItem.gap(8)],
                  ),
              },
              padding: EdgeInsets.only(bottom: Dimensions.h(190)),
            ),

            // Back button
            SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  top: Dimensions.h(8),
                  start: Dimensions.w(16),
                ),
                child: Container(
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
              ),
            ),

            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator()),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RouteInfoCard(controller: controller),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildError(String message) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.w(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off_outlined,
                size: Dimensions.w(56), color: AppColors.greyColor),
            SizedBox(height: Dimensions.h(16)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Dimensions.f(15), color: AppColors.blackColor),
            ),
            SizedBox(height: Dimensions.h(24)),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
