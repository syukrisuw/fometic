import 'package:fometic/components/setara_scaffold.dart';
import 'package:fometic/pages/login/splash_page.dart';
import 'package:get/get.dart';
import 'package:fometic/components/profile_card.dart';
import 'package:fometic/components/search_field.dart';
import 'package:fometic/controllers/main_page_controller.dart';
import 'package:fometic/pages/sections/home/home_section.dart';
import 'package:fometic/utils/responsive/responsive.dart';
import 'package:fometic/utils/strutils/string_constant.dart';
import 'package:flutter/material.dart';

import 'package:fometic/components/side_menu.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

GlobalKey<ScaffoldState> mainpageScaffoldKey = GlobalKey<ScaffoldState>();


class MainPage extends StatelessWidget {
  final String pageTitle = "Fometic Indonesia";
  final Widget initialContentWidget = HomeSection();

  MainPage({Key? key}) : super(key: key);

//  MainPage({Key? key, required this.pageTitle, required this.initialContentWidget}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.put<MainPageController>(MainPageController(),  permanent: true);
    MainPageController controller = Get.find<MainPageController>();
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SetaraScaffold(
          scaffoldKey: mainpageScaffoldKey,
          controller: controller,
          resizeToAvoidBottomInset: true,
          onPressedFAB: (){controller.controlMenu(mainpageScaffoldKey);},
          onClickMenu: (value1, value2) {
            controller.appController
                .onClickMenu(value1, value2);
            mainpageScaffoldKey.currentState!.openEndDrawer();

          },
          appBar: AppBar(
            toolbarHeight: 40,
            leading: const SizedBox(
              width: 10,
            ),
            title: TextButton(
              onPressed: () {
                Get.to(() => SplashPage());
              },
              child: Text(pageTitle),
            ),
            actions: <Widget>[
              const SearchField(),
              GetBuilder<MainPageController>(
                init: MainPageController(),
                builder: (controller) {
                  return Container(
                    child: controller.isUserLoggedIn
                        ? ProfileCard(
                            logOutPressed: () {
                              controller.userLoggedOut();
                              logger.info("User Sign Out");
                            },
                          )
                        : TextButton(
                            child: const Text(SignInText),
                            onPressed: () {
                              controller.userLoggedIn();
                              logger.info("User Sign In");
                            },
                          ),
                  );
                },
              )
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: [
                SizedBox(
                  // Page Container that takes 5/6 part of the screen
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width,
                  child: GetBuilder<MainPageController>(
                    builder: (controller) {
                      if (controller.setaraPageWidget == null) {
                        controller
                            .setupSetaraSectionWidget(initialContentWidget);
                      }

                      return controller.setaraPageWidget!;
                    },
                  ),
                ),
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    // and it takes 1/6 part of the screen
                    child: SideMenu(onClickMenu: (value1, value2) {
                      controller.appController
                          .onClickMenu(value1, value2);
                    }),
                  ),
              ],
            ),
          ),
        ));
  }
}
