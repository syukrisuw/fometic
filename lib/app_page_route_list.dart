import 'package:fometic/pages/login/login_page.dart';
import 'package:fometic/pages/teammanagement/teammgt_page.dart';
import 'package:get/get.dart';
import 'package:fometic/bindings/main_binding.dart';
import 'package:fometic/pages/sections/home/home_section.dart';
import 'package:fometic/pages/main_page.dart';

import 'package:fometic/routes/app_routes.dart';
import 'package:fometic/utils/strutils/string_constant.dart';

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
  ];
}