
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

class DemoPageController extends GetxController {



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

  FormToken? tempFormToken;


  @override
  void onInit() {
    super.onInit();
    logger.info("onInit");
    formTitle.value = "Login Form";
    isRegistering.value = false;
    submitBtnText.value = textLogin;
    hideOrShowPassword.value = true;
  }

  @override
  void onReady() {
    super.onReady();
    logger.info("onReady");
  }

  @override
  void dispose() {
    logger.info("dispose");
    super.dispose();
  }

  @override
  void onClose() {
    logger.info("onClose");
    super.onClose();
  }

  @override
  void refresh() {
    super.refresh();
    logger.info("refresh");
  }
}