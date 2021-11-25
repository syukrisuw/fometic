import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fometic/controllers/main_page_controller.dart';


import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class MainPage extends StatelessWidget {
  static const TAG = "MainPage";
  String title = "";
  String strPlatform = "";


  MainPage({required String title}){
    if (kIsWeb) {
      //String strPlatform = StrWebUtil.getOSInsideWeb();
      String strPlatform = "Window";
      this.title = "$title FlutterWebAdmin On $strPlatform";

    } else {
      if (io.Platform.isAndroid) {
        // Android-specific code
        this.title = "$title FlutterAdmin On $strPlatform";
      } else if (io.Platform.isIOS) {
        // iOS-specific code
        this.title = "$title FlutterAdmin On $strPlatform";
      } else if (io.Platform.isWindows) {
        // iOS-specific code
        this.title = "$title FlutterAdmin On $strPlatform";
      }
    }

  }




  @override
  Widget build(BuildContext context) {
    logger.info("[$TAG]");
    return GetBuilder<MainPageController>(
      builder: (controller) {
        return Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(title),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: controller.showText(context)));
                },
              ),
            ],
          ),
          body: Container(
            child: Text("Main Page of $title"),
          )
        );
      },
    );
  }
 /* List<Widget> _buildScreens() {
    return [
      HomePage(),
      FavouritesPage(),
      EventsPage(),
      HistoriesPage(),
      SettingsPage()
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems(MainController controller, BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_favorites_alt),
        title: ("Favourites"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.alarm),
        title: ("Events"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_list),
        title: ("Histories"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
*/


}
