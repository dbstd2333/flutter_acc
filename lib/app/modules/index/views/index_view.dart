import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/index_controller.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    final ctl = Get.put(IndexController());
    List<String> nameitems = [];
    List<double> moneyitems = [];
    List<String> date = [];
    if (ctl.kv.read('listdata_name') == null) {
      nameitems = ['0'];
      moneyitems = [10];
      date = ['0'];
      print('null');
    } else {
      jsonDecode(ctl.kv.read('listdata_name')).then((data) {
        nameitems = data;
      }, onError: (error) {
        print('Error decoding JSON: $error');
      });
      jsonDecode(ctl.kv.read('listdata_money')).then((data) {
        moneyitems = data;
      }, onError: (error) {
        print('Error decoding JSON: $error');
      });
      jsonDecode(ctl.kv.read('listdata_date')).then((data) {
        date = data;
      }, onError: (error) {
        print('Error decoding JSON: $error');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '首页',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          AwesomeNotifications().createNotification(
              content: NotificationContent(
                  id: 10,
                  channelKey: 'basic_channel',
                  title: '还钱！',
                  body: '还有 ${nameitems.length.toString()} 位老登没还钱，记得催！',
                  actionType: ActionType.Default));
          Fluttertoast.showToast(
            msg: "输入数字时请勿输入字符！否则会导致崩溃！",
            toastLength: Toast.LENGTH_LONG,
          );
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0)),
            ),
            builder: (BuildContext context) {
              return Container(
                height: 700,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '新增老登',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        height: 60,
                        width: screenWidth - 40,
                        child: const TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            labelText: '老登叫什么',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        height: 90,
                        width: screenWidth - 40,
                        child: const TextField(
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              labelText: '欠了多少(元)',
                              helperText: '例如：100.00（别输入字符，崩了你修啊？）'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        height: 60,
                        width: screenWidth - 40,
                        child: const TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            labelText: '啥时候欠的',
                          ),
                        ),
                      ),
                      Expanded(
                        child:
                            Container(), // This expanded container will take remaining space
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                        width: screenWidth - 40,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: "成功新增一老登！",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          },
                          child: const Text(
                            '新增',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Row(
              children: [
                const Text(
                  '还有 ',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  nameitems.length.toString(),
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
                ),
                const Text(
                  ' 位老登',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: const Text(
              '没还钱！',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
            ),
          ),
          if (nameitems.isEmpty == true)
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: const Text(
                '恭喜，没有哪个老登欠你马内',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                physics: const NeverScrollableScrollPhysics(), //禁用滑动事件
                itemCount: nameitems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: SizedBox(
                      height: 90,
                      width: 400,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                        child: Row(
                          children: [
                            Container(
                              //alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Text(
                                      nameitems[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Text(
                                    date[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child:
                                  Container(), // This expanded container will take remaining space
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    '￥',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18.0,
                                        color: Colors.red),
                                  ),
                                  Text(
                                    moneyitems[index].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 28.0,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
