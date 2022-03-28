import 'package:get/get.dart';
import 'package:flutter/material.dart';
class RegisterController extends GetxController {
   RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
}
