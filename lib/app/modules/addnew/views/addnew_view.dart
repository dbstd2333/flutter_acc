import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/addnew_controller.dart';

class AddnewView extends GetView<AddnewController> {
  const AddnewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加新的老登'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(30, 100, 30, 10),
            height: 60,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '老登叫什么',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            height: 60,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '欠了多少',
              ),
            ),
          )
        ],
      ),
    );
  }
}
