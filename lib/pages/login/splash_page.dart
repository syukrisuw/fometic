//import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fometic/components/custom_container.dart';
import 'package:get/get.dart';
import 'package:fometic/controllers/main_page_controller.dart';
import 'package:flutter/material.dart';

import 'package:fometic/utils/strutils/constants.dart';

import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class SplashPage extends GetView<MainPageController> {
  @override
  Widget build(BuildContext context) {

    var xwidth = 0.0;
    var xheight = 0.0;
    var xdpi = 0.0;
    String appPlatform = "";
    String webPlatform = "";
    String osInfo = "";
    var ywidth = 0.0;
    var yheight = 0.0;
    var zwide = 0.0;
    var zheight = 0.0;

    xwidth = MediaQuery.of(context).size.width;
    xheight = MediaQuery.of(context).size.height;
    xdpi = MediaQuery.of(context).devicePixelRatio;
    webPlatform = kIsWeb ? "Web Application" : "OS Application";

    //comment below for web (can't use dart:io on web
    //appPlatform = Platform.isAndroid? "Android" : "Non Android";
    //osInfo = Platform.operatingSystem;



    logger.info(
        "xwidth: $xwidth , xheight: $xheight , xdpi: $xdpi , appPlatform: $appPlatform , osInfo:$osInfo , webPlatform: $webPlatform");

    return SafeArea(
      child: Stack(
        children: [
          Container(
            child: Column(children: [
              Expanded(
                flex: 2,
                child: CustomContainer(cccolor: Colors.blue),
              ),
              Expanded(
                  flex: 3,
                  child: CustomContainer(cccolor: Colors.greenAccent),
              ),
              Expanded(
                  flex: 5,
                  child: CustomContainer(cccolor: Colors.blue),
              ),
            ]),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const SizedBox(height: defaultPadding),
                Center(
                  child: Text("Splash Screen ywidth ${MediaQuery.of(context).size.width} "
                      "  yheight: ${MediaQuery.of(context).size.height}",
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
