import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';

import '../../../../core/responsive_layout/responsive_layout.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../controller/show_map_controller.dart';

class ShowMapScreen extends StatefulWidget {
  const ShowMapScreen({super.key});

  @override
  State<ShowMapScreen> createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {

  ShowMapController controller = Get.put(ShowMapController());


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobile(),

    );
  }

  Widget _buildMobile() {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
        Image.asset(AppImages.mapImage,width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
          Positioned(
            top: 70,
              left: 18,
              child: IconButton(
              onPressed: (){

                Get.back();


              },
                  icon: Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,fontWeight: FontWeight.bold,)
              ))

      ],

    ),
    );
  }
}
