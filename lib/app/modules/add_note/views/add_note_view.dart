import 'package:crud_supbase/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';
import '../../home/controllers/home_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  final homeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddNoteView'),
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
                    // eksekusi add note
                    bool res = await controller.addNote();
                    if (res == true) {
                      await homeC.getAllNotes();
                      Get.back();
                    }
                  }
                },
                icon: Icon(Icons.save),
                label: Text(
                    controller.isLoading.isFalse ? "ADD NOTE" : "Loading...."),
              )),
        ],
      ),
    );
  }
}
