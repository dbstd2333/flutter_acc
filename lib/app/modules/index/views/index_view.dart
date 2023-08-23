import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ctl = Get.put(IndexController());
    final List<String> items = List.generate(100, (index) => 'Item $index');
    MediaQueryData queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;

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
          print('add');
        },
      ),
      body: ListView(
        children: [
          MaterialButton(
            onPressed: () {
              print('object');
            },
            child: const Text('object'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: const Row(
              children: [
                Text(
                  '还有 ',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '100',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
                ),
                Text(
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
              physics: const NeverScrollableScrollPhysics(), //禁用滑动事件
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: SizedBox(
                    width: 400,
                    height: 90,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text(
                                    '小明 $index',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18),
                                  ),
                                ),
                                Text(
                                  '14天前借出',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.fromLTRB(120, 0, 5, 0),
                            child: const Row(
                              children: [
                                Text(
                                  '￥',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18.0,
                                      color: Colors.red),
                                ),
                                Text(
                                  '20.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 28.0,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          )
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
