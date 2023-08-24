import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ctl = Get.put(UserController());
    return Scaffold(
      body: Column(
        children: [
          Text('UserView'),
          ElevatedButton(
              onPressed: () {
                ctl.initdata();
                ctl.getdata();
              },
              child: Text('初始化列表数据库'))
        ],
      ),
    );
  }
}
