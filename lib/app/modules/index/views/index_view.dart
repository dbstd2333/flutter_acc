import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '首页',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('add');
        },
      ),
      body: ListView(
        children: [
          Card(
            elevation: 0,
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: const SizedBox(
              width: 300,
              height: 100,
              child: Column(
                children: [
                  Text('今日支出'),
                  Text('0.00'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
