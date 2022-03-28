import 'package:crud_supbase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "Email ",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 20),
          Obx(() => TextField(
                obscureText: controller.isHidden.value,
                autocorrect: false,
                controller: controller.passC,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () => controller.isHidden.toggle(),
                      icon: controller.isHidden.isTrue
                          ? Icon(Icons.remove_red_eye)
                          : Icon(Icons.remove_red_eye_outlined)),
                  labelText: "Password ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )),
          SizedBox(height: 30),
          Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 50),
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  // Eksekusi Login
                }
              },
              child: Text(
                controller.isLoading.isFalse ? "LOGIN" : "LOADING....",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () => Get.toNamed(Routes.REGISTER),
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
