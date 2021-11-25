import 'package:fometic/components/setara_form_card.dart';
import 'package:fometic/components/setara_scaffold.dart';
import 'package:fometic/controllers/teammgt_controller.dart';
import 'package:fometic/models/setara_reactive_field.dart';
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

class TeammgtPage extends StatelessWidget {
  final String pageTitle = "Fometic Indonesia";
  final Widget initialContentWidget = HomeSection();
  TeammgtPage({Key? key}) : super(key: key);
  final controller = TeammgtController();
//  MainPage({Key? key, required this.pageTitle, required this.initialContentWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainPageController = Get.find<MainPageController>();
    return SetaraScaffold(
      scaffoldKey: controller.scaffoldKey,
      controller: controller,
      onClickMenu: (value1, value2) {controller.appController.onClickMenu(value1, value2, controller.scaffoldKey);},
      onPressedFAB: controller.controlMenu,
      //resizeToAvoidBottomInset: true,
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
          Container(
            child: mainPageController.isUserLoggedIn
                ? ProfileCard(
                    logOutPressed: () {
                      mainPageController.userLoggedOut();
                      logger.info("User Sign Out");
                    },
                  )
                : TextButton(
                    child: const Text(SignInText),
                    onPressed: () {
                      mainPageController.userLoggedIn();
                      logger.info("User Sign In");
                    },
                  ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SetaraFormWidget(
                formTitle: "Test Form",
                formSubTitle: "Testing Form Layout",
                controller: controller,
                reactiveFields: [
                  SetaraReactiveField(
                      //0
                      labelText: 'Email',
                      hintText: "Your Email",
                      controller: controller.emailTxCtr,
                      type: SetaraReactiveFieldType.emailType),
                  SetaraReactiveField(
                      //1
                      labelText: 'Username',
                      hintText: "Your Username",
                      controller: controller.usernameTxCtr,
                      type: SetaraReactiveFieldType.stringType,
                      columnFactor: 4),
                  SetaraReactiveField(
                      //2
                      labelText: 'First Name',
                      hintText: "Your First Name",
                      type: SetaraReactiveFieldType.stringType,
                      columnFactor: 4),
                  SetaraReactiveField(
                      //3
                      labelText: 'Middle Name',
                      hintText: "Your Middle Name",
                      type: SetaraReactiveFieldType.stringType,
                      columnFactor: 2),
                  SetaraReactiveField(
                      //4
                      labelText: 'Last Name',
                      hintText: "Your Last Name",
                      type: SetaraReactiveFieldType.stringType,
                      columnFactor: 4),
                  SetaraReactiveField(
                      //5
                      labelText: 'Password',
                      hintText: "Your Password",
                      type: SetaraReactiveFieldType.stringType,
                      columnFactor: 4),
                  SetaraReactiveField(
                      //6
                      labelText: 'Confirm Password',
                      hintText: "Confirm Your Password",
                      type: SetaraReactiveFieldType.stringType,
                      columnFactor: 4),
                  SetaraReactiveField(
                    //7
                    // fill all width
                    labelText: "Spacer Don't Need Label",
                    hintText: "Spacer",
                    type: SetaraReactiveFieldType.spacerType,
                  ),
                  SetaraReactiveField(
                      //8
                      labelText: 'Submit',
                      hintText: "Submit Form Button",
                      type: SetaraReactiveFieldType.buttonType,
                      onPressed: controller.onSubmitButtonPressed,
                      columnFactor: 2),
                  SetaraReactiveField(
                      //9
                      labelText: 'Cancel',
                      hintText: "Cancel Form Button",
                      type: SetaraReactiveFieldType.buttonType,
                      onPressed: controller.onCancelButtonPressed,
                      columnFactor: 2),
                ],
              ),
            ),

            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                // and it takes 1/6 part of the screen
                child:
                    SideMenu(onClickMenu: (value1, value2) {controller.appController.onClickMenu(value1, value2, controller.scaffoldKey);}),
              ),
          ],
        ),
      ),
    );
  }
}
