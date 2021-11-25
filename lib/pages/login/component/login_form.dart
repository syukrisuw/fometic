import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fometic/controllers/login_page_controller.dart';
import 'package:fometic/utils/responsive/responsive.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';


class LoginForm extends GetView<LoginPageController> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginPageController>(
        init: LoginPageController(),
        builder: (controller) {
          return Form(
            key: controller.formStateKey,
            child: SizedBox(
                width: MediaQuery.of(context).size.width - minPadding,
                height: Responsive.isMobilePotrait(context) ? 300 : 200,
                child: LayoutBuilder(builder: (context, constraints) {
                  return GridView.builder(
                    padding: const EdgeInsets.only(top: minPadding),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return TextFormField(
                              controller: controller.userNameTxCtr,
                              style: const TextStyle(
                                fontSize: formContentTextSize * smallScaleFactor,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: minPadding),
                                border: OutlineInputBorder(),
                                labelText: "Username",
                                hintText: "Username Anda",
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan User Name Anda';
                                }
                                return null;
                              },
                            );
                      } else if (index == 1) {
                        return Obx(() => TextFormField(
                                  style: const TextStyle(
                                    fontSize: formContentTextSize * smallScaleFactor,
                                  ),
                                  controller: controller.passwordTxCtr,
                                  obscureText:
                                      controller.hideOrShowPassword.value,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: minPadding),
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      constraints: const BoxConstraints(
                                        maxHeight: maxIconHeight,
                                      ),
                                      padding: EdgeInsets.zero,
                                      icon: SvgPicture.asset(
                                        controller.hideOrShowPassword.value
                                            ? "assets/icons/visibility.svg"
                                            : "assets/icons/visibility_off.svg",
                                        allowDrawingOutsideViewBox: false,
                                        color: Colors.black26,
                                        height: 30,
                                        width: 30,
                                      ),
                                      onPressed: controller.onHideOrShowPressed,
                                    ),
                                  ),
                                ));
                      } else if (index == 2) {
                        return ElevatedButton(
                          onPressed: controller.onPressSubmitBtn,
                          child: Text("Login",
                              style: Theme.of(context).textTheme.button),
                        );
                      } else if (index == 3) {
                        return ElevatedButton(
                          onPressed: controller.onPressCancelBtn,
                          child: Text("Kembali",
                              style: Theme.of(context).textTheme.button),
                        );
                      } else {
                        return const SizedBox(
                            width: minPadding, height: minPadding);
                      }
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: minPadding,
                      mainAxisSpacing: minPadding,
                      crossAxisCount:
                          Responsive.isMobilePotrait(context) ? 1 : 2,
                      childAspectRatio: Responsive.isMobilePotrait(context)
                          ? 50 * medScaleFactor / formContentHeight
                          : 50 * medScaleFactor / formContentHeight,
                    ),
                  );
                })),
          );
        });
  }
}
