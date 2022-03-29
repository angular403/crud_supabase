import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase supabase = await Supabase.initialize(
    url: "https://maovligqfysccydolvih.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1hb3ZsaWdxZnlzY2N5ZG9sdmloIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDg0OTU3MTUsImV4cCI6MTk2NDA3MTcxNX0.iHYeYXFabsRzYhaEGGNob857abpIxJ227Q_HNU0Kn7A",
  );

  await supabase.client.auth.signOut();

  print("==================");
  print(supabase.client.auth.session()?.toJson());

  final authC = Get.put(AuthController(), permanent: true);

  runApp(
    GetMaterialApp(
      title: "Supanote",
      initialRoute:
          supabase.client.auth.currentUser == null ? Routes.LOGIN : Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
