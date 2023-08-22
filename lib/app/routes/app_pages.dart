import 'package:get/get.dart';

import '../modules/filterlist/bindings/filterlist_binding.dart';
import '../modules/filterlist/views/filterlist_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/index/bindings/index_binding.dart';
import '../modules/index/views/index_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INDEX,
      page: () => const IndexView(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: _Paths.FILTERLIST,
      page: () => const FilterlistView(),
      binding: FilterlistBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
  ];
}
