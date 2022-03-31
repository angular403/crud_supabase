import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditNoteController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<bool> editNote(int id) async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoading.value = true;
      await client.from("notes").update({
        "title": titleC.text,
        "desc": descC.text,
      }).match({"id": id}).execute();
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }
}
