import 'package:crud_supbase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../../../controllers/auth_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.logout();
              await authC.reset();
              Get.offAllNamed(Routes.LOGIN);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder(
          future: controller.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.red),
              );
            }
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                TextField(
                  autocorrect: false,
                  controller: controller.nameC,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Name ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  readOnly: true,
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
                  labelText: "New Password ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )),
              SizedBox(height: 20),
                Text(
                  "Last Login : ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Obx(
                  () => Text(
                    "${controller.lastLogin}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
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
                    onPressed: () async{
                      if (controller.isLoading.isFalse) {
                        // Eksekusi Update Profile
                      await  controller.updateProfile();
                      if(controller.passC.text.isNotEmpty && controller.passC.text.length > 6)
                      {
                        await controller.logout();
                        await authC.reset();
                        Get.offAllNamed(Routes.LOGIN);

                      }
                      }
                    },
                    child: Text(
                      controller.isLoading.isFalse
                          ? "UPDATE PROFILE"
                          : "LOADING....",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
