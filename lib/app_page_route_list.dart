import 'package:fometic/pages/demo/demo_page.dart';
import 'package:fometic/pages/login/login_page.dart';
import 'package:fometic/pages/teammanagement/teammgt_page.dart';
import 'package:get/get.dart';
import 'package:fometic/pages/main_page.dart';

import 'package:fometic/utils/navigations/routes/app_routes.dart';

class AppPageRouteList {
  static var list = [
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainPage(),
    ),
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => MainPage(),
    ),
    GetPage(
      name: AppRoutes.TEAM,
      page: () =>  TeammgtPage(),
    ),
    GetPage(
      name: AppRoutes.DEMO,
      page: () =>  DemoPage(),
    ),
  ];
}