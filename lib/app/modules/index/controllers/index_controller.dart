import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get_storage/get_storage.dart';

class IndexController extends GetxController {
  final kv = GetStorage('listdata');
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
  }
}
