import 'package:flutter/material.dart';
import 'package:fometic/pages/main_page.dart';
import 'package:fometic/pages/sections/agenda/agenda_section.dart';
import 'package:fometic/pages/sections/dashboard/dashboard_section.dart';
import 'package:fometic/pages/sections/home/home_section.dart';
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

  void onClickMenu(String menuName, String actionPushed ) {
    logger.info("onClickMenu $menuName");
    switch (menuName) {
      case "Home":
        {
          //setupSetaraSectionWidget(HomeSection());
          //Get.back();
          //Get.offNamedUntil("/", ModalRoute.withName('/'));
          //Get.offAll(()=>MainPage());
          //Get.toNamed("/");
          Get.offNamed("/");
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
          Get.offNamed("/team"); //to dynamically use menu, must go to page with offnamed so the previous widget got cleared
          //Get.to(()=>TeammgtPage());
          //Get.toNamed("/team");
        }
        break;
      case "Theme":
        {
          Get.changeTheme(Get.isDarkMode? AppTheme.light : AppTheme.dark);
          logger.info("Change Theme");
        }
        break;
      default:
        {
          setupSetaraSectionWidget(HomeSection());   //Simple No Controller landingpage section
          update();
        }
        break;
    }

  }

}