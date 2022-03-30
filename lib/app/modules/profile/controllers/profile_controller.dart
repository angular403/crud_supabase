import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  RxString lastLogin = "".obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  // Fitur Get Profile
  Future<void> getProfile() async {
    PostgrestResponse<dynamic> res = await client.from("users").select().match({
      "uid": client.auth.currentUser!.id,
    }).execute();

    Map<String, dynamic> user =
        (res.data as List).first as Map<String, dynamic>;

    nameC.text = user["name"];
    emailC.text = user["email"];

    // Fitur Last Login
    lastLogin.value = DateFormat.yMMMEd()
        .add_jms()
        .format(DateTime.parse(client.auth.currentUser!.lastSignInAt!));
  }

  // Fitur Logout
  Future<void> logout() async {
    await client.auth.signOut();
  }

  // Fitur Update Profile

  void updateProfile() async {
    if (nameC.text.isNotEmpty) {
      isLoading.value = true;
      await client.from("users").update({
        "name": nameC.text,
      }).match({
        "uid": client.auth.currentUser!.id,
      }).execute();
      isLoading.value = true;
      Get.back();
    }
  }
}
