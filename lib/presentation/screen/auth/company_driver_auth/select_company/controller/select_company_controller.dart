import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SelectCompanyController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  final selectCompanyController = TextEditingController();
  final  idController = TextEditingController();



  @override
  void dispose() {
    selectCompanyController.dispose();
    idController.dispose();
    super.dispose();
  }




}