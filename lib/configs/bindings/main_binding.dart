import 'package:fometic/controllers/demo_page_controller.dart';
import 'package:fometic/controllers/login_page_controller.dart';
import 'package:fometic/controllers/teammgt_controller.dart';
import 'package:get/get.dart';
import 'package:fometic/controllers/dashboard_controller.dart';
import 'package:fometic/controllers/main_page_controller.dart';
import 'package:fometic/controllers/transaction_controller.dart';


class MainBinding extends Bindings {

  @override
  void dependencies() {
    //Cannot using tag because the controller used in GetView
    Get.put<MainPageController>(MainPageController(),  permanent: true);
    Get.lazyPut(()=>LoginPageController(), fenix: true);
    Get.put<DemoPageController>(DemoPageController(),  permanent: true);
    Get.put<TeammgtController>(TeammgtController(),  permanent: true);
    //Get.lazyPut(()=>TeammgtController(), fenix: true);
    //Get.put(TransactionController());
    Get.lazyPut(()=>TransactionController(), fenix: true, tag: "TransactionControllerTag");
    Get.lazyPut(()=>DashboardController(), fenix: true, tag: "DashboardControllerTag");

  }
}