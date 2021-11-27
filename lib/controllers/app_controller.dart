import 'package:flutter/material.dart';
import 'package:fometic/pages/main_page.dart';
import 'package:fometic/pages/sections/agenda/agenda_section.dart';
import 'package:fometic/pages/sections/dashboard/dashboard_section.dart';
import 'package:fometic/pages/sections/home/home_section.dart';
import 'package:fometic/pages/teammanagement/teammgt_page.dart';
import 'package:fometic/utils/themes/app_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:simple_logger/simple_logger.dart';

import 'package:shared_preferences/shared_preferences.dart';

final logger = SimpleLogger();

class AppController extends GetxController {
  Widget? setaraPageWidget;
  late SharedPreferences appSharedPrefereces;

  @override
  void onInit() {
    super.onInit();
    Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('startTime', DateTime.now().toString() );
      appSharedPrefereces = prefs;
      logger.info("onInit : appSharedPrefereces : ${appSharedPrefereces.getKeys().toString()}");
      return prefs;
    }, permanent: true);
    logger.info('onInit');
  }

  @override
  void refresh() {
    logger.info('refresh');
  }

  @override
  void onReady() {
    super.onReady();
    super.onReady();
    logger.info("onReady");
  }

  void setupSetaraSectionWidget(Widget pageWidget) {
    setaraPageWidget = pageWidget;
    update();
  }

  void onClickMenu(String menuName, String actionPushed, GlobalKey<ScaffoldState> scaffoldKey) {
    switch (menuName) {
      case "Home":
        {
          //setupSetaraSectionWidget(HomeSection());
          //Get.back();
          //Get.offNamedUntil("/", ModalRoute.withName('/'));
          //Get.offAll(()=>MainPage());
          //Get.offNamed("/");
          Get.offNamed("/home");
          //update();
        }
        break;

      case "Dashboard":
        {
          setupSetaraSectionWidget(DashboardSection());
        }
        break;

      case "Agenda":
        {
          setupSetaraSectionWidget(AgendaSection());
        }
        break;
      case "Demo":
        {
          Get.toNamed("/demo");
        }
        break;
      case "Team":
        {
          Get.offNamed("/team");
          //Get.to(()=>TeammgtPage());
          //Get.offNamed("/");
        }
        break;
      case "Theme":
        {
          Get.changeTheme(Get.isDarkMode? AppTheme.light : AppTheme.dark);
          update();
        }
        break;
      default:
        {
          setupSetaraSectionWidget(HomeSection());   //Simple No Controller landingpage section
          update();
        }
        break;
    }


    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    }

  }

}