import 'package:crud_supbase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController(text: "wiliam@gmail.com");
  TextEditingController passC = TextEditingController(text: "admin123");

  SupabaseClient client = Supabase.instance.client;

  Future<bool?> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      // Eksekusi email dan password disini
      isLoading.value = true;
      GotrueSessionResponse response =
          await client.auth.signIn(email: emailC.text, password: passC.text);
      isLoading.value = false;

      if (response.error == null) {
        // Tidak ada error -> berhasil Login
        print("------------");
        print(response.data?.toJson());

        // Tanpa fitur email vertification
        return true;
      } else {
        Get.snackbar("terjadi kesalahan", response.error!.message);
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email Dan Password Belum Diisi.");
    }
  }
}
