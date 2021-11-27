import 'package:fometic/components/setara_form_card.dart';
import 'package:fometic/components/setara_responsive_form_card.dart';
import 'package:fometic/components/setara_scaffold.dart';
import 'package:fometic/controllers/teammgt_controller.dart';
import 'package:fometic/models/setara_reactive_field.dart';
import 'package:fometic/pages/login/splash_page.dart';
import 'package:fometic/utils/strutils/constants.dart';
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
final bucketGlobal = PageStorageBucket();

List<GlobalKey<FormState>> formKeyList = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>()
];

class TeammgtPage extends GetView<TeammgtController> {
//  static final List<GlobalKey<FormState>> formKeyList = [GlobalKey<FormState>(),GlobalKey<FormState>(),];
  //static final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final String pageTitle = "Fometic Indonesia";
  final Widget initialContentWidget = HomeSection();
  TeammgtPage({Key? key}) : super(key: key);
//  MainPage({Key? key, required this.pageTitle, required this.initialContentWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainPageController = Get.find<MainPageController>();

    List<Widget> formList = [
      Form(
        key: formKeyList[0],
        child: SetaraResponsiveFormCardWidget(
          setaraWidgetKey: const ValueKey("form 1"),
          formTitle: "Test Form 1",
          initialFocusNode: controller.initialFocusNode,
          formSubTitle: "Testing Form Layout",
          //controller: controller,
          reactiveFields: [
            // SetaraReactiveField(
            //   //0
            //     labelText: 'Email',
            //     hintText: "Your Email",
            //     //textStyle: const TextStyle(fontSize: 100),
            //     controller: controller.emailTxCtr,
            //     type: SetaraReactiveFieldType.emailType),
            // SetaraReactiveField(
            //   //1
            //     labelText: 'Username',
            //     hintText: "Your Username",
            //     //textStyle: const TextStyle(fontSize: 100),
            //     controller: controller.usernameTxCtr,
            //     type: SetaraReactiveFieldType.stringType,
            //     columnFactor: 4),
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
            // SetaraReactiveField(
            //   //5
            //     labelText: 'Password',
            //     hintText: "Your Password",
            //     type: SetaraReactiveFieldType.stringType,
            //     columnFactor: 4),
            // SetaraReactiveField(
            //   //6
            //     labelText: 'Confirm Password',
            //     hintText: "Confirm Your Password",
            //     type: SetaraReactiveFieldType.stringType,
            //     columnFactor: 4),
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
      Form(
          key: formKeyList[2],
          child: Column(children: [
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
          ])),
      Form(
        key: formKeyList[1],
        child: SetaraResponsiveFormCardWidget(
          setaraWidgetKey: const ValueKey("form 2"),
          //initialFocusNode: controller.initialFocusNode,
          formTitle: "Test Form 2",
          formSubTitle: "Testing Form Layout",
          //controller: controller,
          reactiveFields: [
            SetaraReactiveField(
                //0
                labelText: 'Email',
                hintText: "Your Email",
                //textStyle: const TextStyle(fontSize: 100),
                controller: controller.emailTxCtr,
                type: SetaraReactiveFieldType.emailType),
            SetaraReactiveField(
                //1
                labelText: 'Username',
                hintText: "Your Username",
                //textStyle: const TextStyle(fontSize: 100),
                controller: controller.usernameTxCtr,
                type: SetaraReactiveFieldType.stringType,
                columnFactor: 4),
            // SetaraReactiveField(
            //     //2
            //     labelText: 'First Name',
            //     hintText: "Your First Name",
            //     type: SetaraReactiveFieldType.stringType,
            //     columnFactor: 4),
            // SetaraReactiveField(
            //     //3
            //     labelText: 'Middle Name',
            //     hintText: "Your Middle Name",
            //     type: SetaraReactiveFieldType.stringType,
            //     columnFactor: 2),
            // SetaraReactiveField(
            //     //4
            //     labelText: 'Last Name',
            //     hintText: "Your Last Name",
            //     type: SetaraReactiveFieldType.stringType,
            //     columnFactor: 4),
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
      Form(
          key: formKeyList[3],
          child: Column(children: [
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
          ])),
    ];
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SetaraScaffold(
          scaffoldKey: controller.scaffoldKey, //controller.scaffoldKey,
          controller: controller,
          onClickMenu: (value1, value2) {
            controller.appController
                .onClickMenu(value1, value2, controller.scaffoldKey);
          },
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
          body: PageStorage(
            bucket: bucketGlobal,
            child: SafeArea(
              child: SingleChildScrollView(
                key: controller.teammgtPageKey,
            padding: const EdgeInsets.all(minContentPadding),
            //reverse: true,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    children: formList,
                  ),
                ),

                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    // and it takes 1/6 part of the screen
                    child: SideMenu(onClickMenu: (value1, value2) {
                      controller.appController
                          .onClickMenu(value1, value2, controller.scaffoldKey);
                    }),
                  ),
              ],
            ),
          )),),
        ));
  }
}
