import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';

import 'app_controller.dart';

final logger = SimpleLogger();

class TeammgtController extends GetxController {
  final AppController appController = Get.find<AppController>(tag: "AppController");
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  TextEditingController emailTxCtr = TextEditingController();

  TextEditingController usernameTxCtr = TextEditingController();
  TextEditingController passwordTxCtr = TextEditingController();
  TextEditingController confirmPassTxCtr = TextEditingController();


  @override
  void onInit() {
    super.onInit();
  }

  void onSubmitButtonPressed() {
    logger.info("onSubmitButtonPressed");
  }

  void onCancelButtonPressed() {
    logger.info("onCancelButtonPressed");
  }

  void controlMenu() {
    logger.info("controlMenu Clicked");
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }
}