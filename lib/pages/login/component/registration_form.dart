import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fometic/controllers/login_page_controller.dart';
import 'package:fometic/utils/responsive/responsive.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';


class RegistrationForm extends GetView<LoginPageController> {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginPageController>(
        init: LoginPageController(),
        builder: (controller) {
          return Form(
            key: controller.formStateKey,
            child: SizedBox(
                width: MediaQuery.of(context).size.width - minPadding,
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 20*formContentHeight
                        : 10*formContentHeight,
                child: LayoutBuilder(builder: (context, constraints) {
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: minPadding),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return TextFormField(
                          style: const TextStyle(
                            fontSize: formContentTextSize * smallScaleFactor,
                          ),
                          controller: controller.userNameTxCtr,
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
                        return TextFormField(
                          style: const TextStyle(
                            fontSize: formContentTextSize * smallScaleFactor,
                          ),
                          controller: controller.emailAddressTxCtr,
                          decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.only(left: minPadding),
                            border: OutlineInputBorder(),
                            labelText: "Email",
                            hintText: "Alamat Email Anda",
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan Alamat Email Anda';
                            }
                            return null;
                          },
                        );
                      } else if (index == 2) {
                        return Obx(() => TextFormField(
                              controller: controller.passwordTxCtr,
                              style: const TextStyle(
                                fontSize: formContentTextSize * smallScaleFactor,
                              ),
                              obscureText: controller.hideOrShowPassword.value,
                              decoration: InputDecoration(
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
                      } else if (index == 3) {
                        return Obx(() => TextFormField(
                              style: const TextStyle(
                                fontSize: formContentTextSize * smallScaleFactor,
                              ),
                              controller: controller.passwordConfirmTxCtr,
                              obscureText: controller.hideOrShowPassword.value,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Pasword',
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
                      } else if (index == 4) {
                        return ElevatedButton(
                          onPressed: controller.onPressSubmitBtn,
                          child: Text("Register",
                              style: Theme.of(context).textTheme.button),
                        );
                      } else if (index == 5) {
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
                      childAspectRatio:
                          Responsive.isMobilePotrait(context) ? 50*medScaleFactor/formContentHeight : 50*medScaleFactor/formContentHeight,
                    ),
                  );
                })),
          );
        });
  }
}
