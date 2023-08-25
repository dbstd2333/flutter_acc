import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/index_controller.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    final ctl = Get.put(IndexController());
    ctl.updateui();
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
                  body: '还有 ${ctl.nameitems.length.toString()} 位老登没还钱，记得催！',
                  actionType: ActionType.Default));
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
                        child: TextField(
                          onChanged: ctl.updateInputText_name,
                          decoration: const InputDecoration(
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
                        child: TextField(
                          textAlign: TextAlign.end,
                          onChanged: ctl.updateInputText_money,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
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
                        child: TextField(
                          onChanged: ctl.updateInputText_date,
                          decoration: const InputDecoration(
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
                            ctl.save();
                            ctl.updateui();
                            Navigator.pop(context);
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
      body: GetBuilder<IndexController>(builder: (ctl) {
        return ListView(
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
                    ctl.nameitems.length.toString(),
                    style: const TextStyle(
                        fontSize: 32.0, fontWeight: FontWeight.w900),
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
            if (ctl.nameitems.isEmpty == true ||
                ctl.dateitems.isEmpty == true ||
                ctl.moneyitems.isEmpty == true)
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: const Text(
                  '叼哦，没有哪个老登欠你马内',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                physics: const NeverScrollableScrollPhysics(), //禁用滑动事件
                itemCount: ctl.nameitems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: SizedBox(
                      height: 90,
                      width: 400,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onLongPress: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              '真还了？',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            content: Container(
                              height: 230,
                              child: Column(children: [
                                Text('尊嘟假嘟o.O'),
                                Image.asset(
                                  'assets/sure.jpeg',
                                  height: 200,
                                )
                              ]),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                },
                                child: const Text('手滑'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  ctl.delete(index);
                                },
                                child: const Text('尊嘟'),
                              ),
                            ],
                          ),
                        ),
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
                                        ctl.nameitems[index],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      ctl.dateitems[index],
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
                                      ctl.moneyitems[index].toString(),
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
                    ),
                  );
                },
              ),
          ],
        );
      }),
    );
  }
}
