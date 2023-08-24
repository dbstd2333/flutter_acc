import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexController extends GetxController {
  var inputText_date = ''.obs;
  var inputText_name = ''.obs;
  var inputText_money = 0.0.obs;
  List<String> nameitems = [];
  List<double> moneyitems = [];
  List<String> dateitems = [];

  @override
  void onInit() {
    super.onInit();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        Fluttertoast.showToast(
          msg: "烦请爹授权通知权限！",
          toastLength: Toast.LENGTH_SHORT,
        );
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    print('init done');
  }

  @override
  void onReady() {
    super.onReady();
    print('ready done');
  }

  void updateInputText_date(String newText) {
    inputText_date.value = newText;
    print(inputText_date.value);
  }

  void updateInputText_name(String newText) {
    inputText_name.value = newText;
  }

  void updateInputText_money(String newText) {
    try {
      inputText_money.value = double.parse(newText);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "解析错误，是不是输字符进去了？（逼问",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void updateui() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String moneyJsonData = prefs.getString('listdata_money') ?? '[]';
    try {
      moneyitems = List<double>.from(jsonDecode(moneyJsonData));
    } catch (e) {
      print('Error decoding JSON for money: $e');
      moneyitems = [];
      Fluttertoast.showToast(
        msg: "出大事了！double init err",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    nameitems = prefs.getStringList('listdata_name') ?? [];
    dateitems = prefs.getStringList('listdata_date') ?? [];
    print(nameitems.toString());
    print(dateitems.toString());
    print(moneyitems.toString());
    update();
    debugp();
  }

  void save() async {
    nameitems.add(inputText_name.value);
    moneyitems.add(inputText_money.value);
    dateitems.add(inputText_date.value);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listdata_name', nameitems);
    prefs.setStringList('listdata_date', dateitems);
    prefs.setString('listdata_money', jsonEncode(moneyitems).toString());
    Fluttertoast.showToast(
      msg: "成功新增一老登！",
      toastLength: Toast.LENGTH_SHORT,
    );
    update();
    debugp();
  }

  void onRefresh2() async {
    updateui();
  }

  void debugp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('name：' + prefs.getStringList('listdata_name').toString());
    print('date：' + prefs.getStringList('listdata_date').toString());
    print('money：' + prefs.getString('listdata_money').toString());
  }

  void delete(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    nameitems.removeAt(index);
    moneyitems.removeAt(index);
    dateitems.removeAt(index);
    prefs.setStringList('listdata_name', nameitems);
    prefs.setStringList('listdata_date', dateitems);
    prefs.setString('listdata_money', jsonEncode(moneyitems).toString());
    Fluttertoast.showToast(
      msg: "成功删除一老登！",
      toastLength: Toast.LENGTH_SHORT,
    );
    update();
    debugp();
  }
}
