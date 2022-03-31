import 'package:crud_supbase/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/note_model.dart';
import '../controllers/home_controller.dart';
import '../../../controllers/auth_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: FutureBuilder(
          future: controller.getAllNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            }
            return Obx(() => controller.allNotes.length == 0
                ? Center(
                    child: Text("Tidak Ada Data Notes"),
                  )
                : ListView.builder(
                    itemCount: controller.allNotes.length,
                    itemBuilder: (context, index) {
                      Note note = controller.allNotes[index];
                      return ListTile(
                        onTap: () {
                          Get.toNamed(Routes.EDIT_NOTE, arguments: note);
                        },
                        leading: CircleAvatar(
                          child: Text("${note.id}"),
                        ),
                        title: Text("${note.title}"),
                        subtitle: Text("${note.desc}"),
                        trailing: IconButton(
                            onPressed: () => controller.deleteNote(note.id!),
                            icon: Icon(Icons.delete),
                            color: Colors.red),
                      );
                    },
                  ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_NOTE);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
