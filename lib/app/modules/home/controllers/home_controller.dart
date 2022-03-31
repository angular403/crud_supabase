// import
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/note_model.dart';

// Class HomeController
class HomeController extends GetxController {
  RxList allNotes = List<Note>.empty().obs;
  SupabaseClient client = Supabase.instance.client;

  // GetAllNotes
  Future<void> getAllNotes() async {
    PostgrestResponse<dynamic> user = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id}).execute();
    int id = (user.data as List).first["id"];

    var notes = await client.from("notes").select().match({
      "user_id": id,
    }).execute();

    List<Note> dataNote = Note.fromJsonList((notes.data as List));

    allNotes(dataNote);
    allNotes.refresh();
    print(notes.toJson());
  }

  // Delete Note
  void deleteNote(int id) async {
    await client.from("notes").delete().match({"id": id}).execute();
    await getAllNotes();
  }
}
