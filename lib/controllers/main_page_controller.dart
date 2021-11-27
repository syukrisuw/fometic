import 'package:flutter/material.dart';
import 'package:fometic/controllers/app_controller.dart';
import 'package:fometic/pages/login/login_page.dart';
import 'package:fometic/pages/main_page.dart';
import 'package:fometic/pages/teammanagement/teammgt_page.dart';
import 'package:get/get.dart';
import 'package:fometic/models/transaction_model.dart';


//final logger = SimpleLogger();

class MainPageController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late AppController appController;
  static const TAG = "MainController";
  var isUserLoggedIn = false;
  var userName = "";
  Widget? setaraPageWidget;
  var transactionModelList = <TransactionModel>[];

  @override
  void onInit() {
    super.onInit();
    appController =  Get.find<AppController>(tag: "AppController");

    //logger.info("$TAG");

  }


  @override
  void dispose() {
    //logger.info("dispose");
  }


  @override
  void onReady() {
    super.onReady();
    isUserLoggedIn = false;
    //logger.info("onReady");
  }

  @override
  void refresh() {
    //logger.info("refresh");
    super.refresh();
  }

  @override
  void onClose() {
    //logger.info("onClose");
  }

  void setupSetaraSectionWidget(Widget pageWidget) {
    setaraPageWidget = pageWidget;
    update();
  }

  void userLoggedIn() async {
    await Get.off(() => const LoginPage());
    //Get.toNamed('/login');
    //isUserLoggedIn = true;
    //update();
  }

  void userLoggedOut() {
    isUserLoggedIn = false;
    update();
  }

  showText(BuildContext context) {
    return Text(
        "Width : ${MediaQuery.of(context).size.width} , Height: ${MediaQuery.of(context).size.height}");
  }



  void controlMenu() {
    //logger.info("controlMenu Clicked");
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }


}
