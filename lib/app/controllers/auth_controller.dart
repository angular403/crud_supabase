import 'dart:async';
import 'package:crud_supbase/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Timer? authTimer;

  SupabaseClient client = Supabase.instance.client;

  Future<void> autoLogout() async {
    if (authTimer != null) {
      authTimer!.cancel();
    }

    authTimer = Timer(Duration(seconds: 3600 - (60 * 5 )), () async {
      await client.auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    });
    print("AUTO LOGOUT DI JALANKAN");
  }

  Future<void> reset() async {
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
  }
}
