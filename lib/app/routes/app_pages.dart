import 'package:get/get.dart';

import '../modules/assets/bindings/assets_binding.dart';
import '../modules/assets/presentation/assets_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.assets,
      page: () => AssetsPage(),
      binding: AssetsBinding(),
    ),
  ];
}
