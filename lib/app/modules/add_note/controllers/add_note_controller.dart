// Import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Class AddNoteController
class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  // Add Note
  void addNote() async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoading.value = true;
      PostgrestResponse<dynamic> user = await client
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id}).execute();
      int id = (user.data as List).first["id"];
      print(user.toJson);
      await client.from("notes").insert({
        "user_id": id,
        "title": titleC.text,
        "desc": descC.text,
        "created_at": DateTime.now().toIso8601String(),
      }).execute();
      isLoading.value = false;
      Get.back();
    }
  }
}
