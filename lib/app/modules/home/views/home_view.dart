import 'package:crud_supbase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../../controllers/auth_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()  async{
             await controller.logout();
            await  authC.reset();
            Get.offAllNamed(Routes.LOGIN);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'HomeView',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
