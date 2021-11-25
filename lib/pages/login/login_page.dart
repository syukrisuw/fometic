import 'package:flutter/material.dart';
import 'package:fometic/components/form_content_decoration.dart';
import 'package:fometic/components/form_header.dart';
import 'package:fometic/pages/login/component/login_form.dart';
import 'package:fometic/pages/login/component/registration_form.dart';
import 'package:fometic/controllers/login_page_controller.dart';
import 'package:fometic/utils/responsive/responsive.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginPageController>(
        init: LoginPageController(),
        builder: (controller) {
          return Scaffold(
              body: SafeArea(
            maintainBottomViewPadding: true,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: minHeightPadding),
                width: double.infinity,
                color: Theme.of(context).backgroundColor,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.bottom,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: minHeightPadding,
                      ),
                      Obx(() => FormHeader(
                            title: controller.formTitle.value,
                          )),
                      Container(
                        //height: MediaQuery.of(context).size.height - 200,
                        width: Responsive.isNonMobile(context)? 700: double.infinity,
                        padding: const EdgeInsets.all(minPadding),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: borderWidthSmall,
                          ),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(borderRadiusMedium)),
                        ),
                        child: controller.isRegistering.value
                            ? RegistrationForm()
                            : LoginForm(),
                      ),
                      //Switch With Message
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: minPadding,
                            ),
                          ),
                          TextButton(
                              onPressed: () => controller.onSwitchLogin(false),
                              child: const Text("Login or",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold))),
                          Switch(
                            value: controller.isRegistering.value,
                            onChanged: (value) {
                              controller.onSwitchLogin(value);
                            },
                            inactiveTrackColor: Colors.grey,
                            inactiveThumbColor: Colors.blue,
                            activeTrackColor: Colors.blue,
                            activeColor: Colors.green,
                          ),
                          TextButton(
                              onPressed: () => controller.onSwitchLogin(true),
                              child: const Text(" Register ",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold))),
                          const Text(" Your Account "),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: minPadding,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        });
  }
}
