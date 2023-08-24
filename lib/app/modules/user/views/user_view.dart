import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    final ctl = Get.put(UserController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '我',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        body: GetBuilder<UserController>(builder: (ctl) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(40, 40, 0, 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('借出总资产：'),
                      Text(
                        ctl.totalmoney.toString(),
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          '你确定啊？',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        content: Container(
                          height: 200,
                          child: Column(children: [
                            Image.asset(
                              'assets/sure.jpeg',
                              height: 200,
                            )
                          ]),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('手滑'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ctl.initdata();
                            },
                            child: const Text('YES'),
                          ),
                        ],
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '初始化列表数据库',
                            style: TextStyle(
                                color: Color.fromARGB(255, 40, 40, 40)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
