import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../index/controllers/index_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class UserController extends GetxController {
  //TODO: Implement UserController
  final idxctl = Get.put(IndexController());
  final count = 0.obs;
  double totalmoney = 0.0;
  List<double> moneyitems = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    gettotal();
  }

  void gettotal() async {
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
    if (moneyitems.isEmpty == true) {
      totalmoney = 0.0;
    } else {
      var sum = 0.0;
      for (var i = 0; i < moneyitems.length; i++) {
        sum = moneyitems[i] + sum;
      }
      totalmoney = sum;
    }
  }

  void initdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listdata_name', []);
    prefs.setStringList('listdata_date', []);
    prefs.setString('listdata_money', '');
    idxctl.moneyitems = [];
    idxctl.nameitems = [];
    idxctl.dateitems = [];
    print('reset done');
    print(prefs.getStringList('listdata_name').toString());
  }
}
