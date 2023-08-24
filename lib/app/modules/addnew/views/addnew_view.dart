import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/addnew_controller.dart';

class AddnewView extends GetView<AddnewController> {
  const AddnewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddnewView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddnewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
