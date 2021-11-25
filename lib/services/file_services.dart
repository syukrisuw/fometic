import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';

import 'package:fometic/utils/web_utils.dart' deferred as setaraWebUtils;
import 'package:fometic/utils/non_web_utils.dart' deferred as setaraNonWebUtils;

final logger = SimpleLogger();

class FileServices extends GetxService {
  //On Android usually: /data/user/0/com.setara.fometic.fometic/app_flutter
  //On Web usually: blob:http://localhost:57347/12a8e966-4f63-4f49-8648-c2d9d1c6125e  (for security web apps not allowed to write file directly to OS
  //late Directory appDocDir;


  @override
  void onInit() {
    super.onInit();
    initServices();
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<void> initServices() async {
    logger.info("initServices");



 //   if (kIsWeb) {
      //String? path = await FilePicker.platform.pickFiles() //getDirectoryPath();
     // logger.info("initServices-appDocDir.path: ${path}");
      //appDocDir = Directory(path!);
//    } else {
//      Directory appDocDir = await getApplicationDocumentsDirectory();
//      logger.info("initServices-appDocDir.path: ${appDocDir.path}");
 //   }

  }

  Future<void> getLocalDirectory() async {
    logger.info("kIsWeb: $kIsWeb");
    if (kIsWeb) {
      //final WebHtml.Storage _localStorage = window.localStorage;
      String localPath = "";
      //Comment bellow for non web
      await setaraWebUtils.loadLibrary();
      setaraWebUtils.WebUtils.getLocalDirectoryPath().then((value) {
        localPath = value;
        logger.info("_localStorage : $localPath");
         });

    } else {
      String localPath = "";
      await setaraNonWebUtils.loadLibrary();
      setaraNonWebUtils.NonWebUtils.getLocalDirectoryPath().then((value) {
        localPath = value;
        logger.info("_localStorage : $localPath");
      });
    }
  }

  Future<void> getSaveDirectory() async {
    logger.info("kIsWeb: $kIsWeb");
    if (kIsWeb) {
      //final WebHtml.Storage _localStorage = window.localStorage;
      String localPath = "";
      await setaraWebUtils.loadLibrary();
      setaraWebUtils.WebUtils.getSavePath().then((value) {
        localPath = value;
        logger.info("_localStorage : $localPath");
      });

    }
  }


  @override
  void onClose() {
    super.onClose();
    logger.info("onClose");
  }
}