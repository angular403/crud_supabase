import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditNoteView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'EditNoteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
