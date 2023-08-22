import 'package:get/get.dart';

import '../controllers/filterlist_controller.dart';

class FilterlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterlistController>(
      () => FilterlistController(),
    );
  }
}
