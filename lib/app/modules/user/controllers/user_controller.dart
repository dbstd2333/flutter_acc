import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  //TODO: Implement UserController

  final count = 0.obs;

  void onInit() {
    super.onInit();
  }

  void initdata() {
    final kv = GetStorage('listdata');
    kv.write('listdata_name', '');
    kv.write('listdata_money', '');
    kv.write('listdata_date', '');
  }

  void getdata() {
    final kv = GetStorage('listdata');
    print(kv.read('listdata_name'));
    print(kv.read('listdata_money'));
  }
}
