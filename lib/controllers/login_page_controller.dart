
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fometic/models/form_token_model.dart';
import 'package:fometic/services/http_services.dart';
import 'package:http/http.dart' as http;
import 'package:fometic/pages/main_page.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class LoginPageController extends GetxController {



  var formTitle = "".obs;
  var isRegistering = false.obs;
  var submitBtnText = "".obs;
  var hideOrShowPassword = true.obs;
  var sessionId = "";
  var csrfTokenId = "";
  var httpClient = http.Client();

  TextEditingController userNameTxCtr = TextEditingController();
  TextEditingController emailAddressTxCtr = TextEditingController();
  TextEditingController passwordTxCtr = TextEditingController();
  TextEditingController passwordConfirmTxCtr = TextEditingController();

  late GlobalKey<FormState> formStateKey;
  FormToken? tempFormToken;


  @override
  void onInit() {
    super.onInit();
    formStateKey = GlobalKey<FormState>();
    formTitle.value = "Login Form";
    isRegistering.value = false;
    submitBtnText.value = textLogin;
    hideOrShowPassword.value = true;
    httpGetToken();
  }



  void onRegister() {

  }

  void onSwitchLogin(bool isRegister) {
    isRegistering.value = isRegister;
    if(isRegister) {
      formTitle.value = "Registration Form";
      submitBtnText.value = textRegister;
    } else {
      submitBtnText.value = textLogin;
      formTitle.value = "Login Form";
    }
    Future.delayed(Duration(milliseconds: 500));

    update();
  }

  void onHideOrShowPressed() {
    hideOrShowPassword.value = !hideOrShowPassword.value;
  }

  void onPressSubmitBtn() {
    Get.off(()=>MainPage());
  }

  void onPressCancelBtn() {
    Get.off(()=>MainPage());
  }

  void httpGetToken() {

    HttpServices httpServices = Get.find<HttpServices>(tag: "HttpServices");
    httpServices.getFormToken().then((value) {
      if (value != null) {
        tempFormToken = value;
        logger.info("httpGetToken : ${tempFormToken!.toJsonString()}");
      }
    });

  }
}