import 'package:crud_supbase/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';
import '../../edit_note/controllers/edit_note_controller.dart';
import '../../../data/models/note_model.dart';
import '../../home/controllers/home_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  final homeC = Get.find<HomeController>();
  Note note = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.titleC.text = note.title!;
    controller.descC.text = note.desc!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Notes'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.titleC,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.descC,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Obx(() => ElevatedButton.icon(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    // eksekusi Edit notes
                    bool res = await controller.editNote(note.id!);
                    if (res == true) {
                      await homeC.getAllNotes();
                      Get.back();
                    }
                  }
                },
                icon: Icon(Icons.update),
                label: Text(
                    controller.isLoading.isFalse ? "EDIT NOTE" : "Loading...."),
              )),
        ],
      ),
    );
  }
}
