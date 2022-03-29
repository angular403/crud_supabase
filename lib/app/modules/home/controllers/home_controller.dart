import 'package:crud_supbase/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  SupabaseClient client = Supabase.instance.client;

 Future<void> logout() async {
    await client.auth.signOut();
    // Get.offAllNamed(Routes.LOGIN);
  }
}
