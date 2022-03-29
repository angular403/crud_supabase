import 'package:crud_supbase/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController nameC = TextEditingController(text: "andrew");
  TextEditingController emailC = TextEditingController(text: "admin@gmail.com");
  TextEditingController passC = TextEditingController(text: "admin123");

  SupabaseClient client = Supabase.instance.client;

  void signUp() async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passC.text.isNotEmpty) {
      // Eksekusi email dan password disini
      isLoading.value = true;
      GotrueSessionResponse response =
          await client.auth.signUp(emailC.text, passC.text);
      isLoading.value = false;

      if (response.error == null) {
        // Tidak ada error -> berhasil sign up
        print("------------");
        print(response.data?.toJson());
        print(response.provider);
        print(response.url);
        print(response.user?.toJson());
        print(response.rawData);

        // insert  data user -> table users
        await client.from("users").insert({
          "email": emailC.text,
          "name": nameC.text,
          "created_at": DateTime.now().toIso8601String(),
          "uid": response.user!.id,
        }).execute();
        // Tanpa fitur email vertification
        Get.offAllNamed(Routes.LOGIN);

        // Get.defaultDialog(
        //   barrierDismissible: false,
        //     title: "Berhasil Register",
        //     middleText: "Periksa dan lakukan email konfirmasi ",
        //     actions: [
        //       OutlinedButton(
        //         onPressed: () {
        //           Get.back(); // Tutup Dialog
        //           Get.back(); // Tutup Login
        //         },
        //         child: Text('Oke, saya mengerti'),
        //       ),
        //     ]);
      } else {
        Get.snackbar("terjadi kesalahan", response.error!.message);
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email Dan Password Belum Diisi.");
    }
  }
}
