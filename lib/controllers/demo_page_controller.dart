
import 'package:flutter/material.dart';
import 'package:fometic/models/form_token_model.dart';
import 'package:http/http.dart' as http;
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';
import 'dart:math' as math;

final logger = SimpleLogger();

class DemoPageController extends GetxController
    with SingleGetTickerProviderMixin {
  var formTitle = "".obs;
  var isRegistering = false.obs;
  var submitBtnText = "".obs;
  var hideOrShowPassword = true.obs;
  var sessionId = "";
  var csrfTokenId = "";
  var httpClient = http.Client();
  bool isAnimating = false;
  late AnimationController _drawerAc;
  var animationTickler = 0.0.obs;
  var previousPageIndex = 0.obs;
  var selectedPageIndex = 0.obs;
  var nextPageIndex = 0.obs;

  bool isInitialized = false;
  double tickler = 0.0;

  TextEditingController userNameTxCtr = TextEditingController();
  TextEditingController emailAddressTxCtr = TextEditingController();
  TextEditingController passwordTxCtr = TextEditingController();
  TextEditingController passwordConfirmTxCtr = TextEditingController();

  FormToken? tempFormToken;

  var isDrawerOpen = false;

  @override
  void onInit() {
    logger.info("onInit");

    super.onInit();
    formTitle.value = "Login Form";
    isRegistering.value = false;
    submitBtnText.value = textLogin;
    hideOrShowPassword.value = true;

    isInitialized = true;
    ///create default AnimationController tickling from 0.0 to 1.0
    _drawerAc = AnimationController(
      vsync: this,
      duration: drawerAnimationDuration,
      reverseDuration: drawerAnimationDuration,
      //    lowerBound: 0.0,
      //    upperBound: 100.0,
    );
    _drawerAc.addListener(_animatingOnProgress);
    _drawerAc.addStatusListener(_updateStatus);
    isInitialized = true;
  }



  @override
  void onReady() {
    super.onReady();
    logger.info("onReady");
  }

  @override
  void dispose() {
    logger.info("dispose");
    _drawerAc.removeStatusListener(_updateStatus);
    _drawerAc.removeListener(_animatingOnProgress);
    _drawerAc.dispose();
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

  void onGestureTap() {
    // SetaraAnimationController animationController = SetaraAnimationController();
    // if (!animationController.isInitialized) {
    //   animationController.onInit();
    // }
    // if (!animationController.isAnimating) {
    //   animationController.forward();
    //   animationController.isAnimating = true;
    // }
    //if (!animationController.isAnimating) {
    //  animationController.dispose();
    // }
    // drawerAc.repeat();
    // drawerAc.addListener(()=>logger.info("Animating : ${drawerAc.value}"));
    // if(isAnimating) {
    //   drawerAc.reverse();
    // } else {
       _drawerAc.forward();
    // }

    logger.info("GestureDetector at Content Tapped!! Animation State : $isAnimating  FORWARD");
  }

  void openDrawer() {
    var  random = math.Random();
    int randomNumber = random.nextInt(4); //random from 0 to 4
    selectedPageIndex.value = randomNumber;
    if(_drawerAc.status != AnimationStatus.completed) {
      _drawerAc.forward();
      logger.info("openDrawer Animation State : $isAnimating  FORWARD");
    }
    isDrawerOpen = true;
  }

  void closeDrawer() {
    if(_drawerAc.status == AnimationStatus.completed) {
      _drawerAc.reverse(from: 1.0);
      logger.info("openDrawer Animation State : $isAnimating  REVERSE");
    }
    isDrawerOpen = false;
    if (selectedPageIndex.value > 0) previousPageIndex.value = selectedPageIndex.value-1;
    if (selectedPageIndex.value < 4) nextPageIndex.value = selectedPageIndex.value+1;
  }

  void onGestureDoubleTap() {

    // SetaraAnimationController animationController = SetaraAnimationController();
    // if (!animationController.isInitialized) {
    //   animationController.onInit();
    // }
    // //if (!animationController.isAnimating) {
    //   animationController.reverse();
    // //  animationController.isAnimating = true;
    // //}
    _drawerAc.reverse(from : 1.0);
    logger.info("GestureDetector at Content Double Tapped! Animation State : $isAnimating  REVERSE");
  }


///Animation method

  void _animatingOnProgress() {
    animationTickler.value = _drawerAc.value;
    logger.info("_animatingOnProgress ${_drawerAc.value}");
  }

  void _updateStatus(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed : {
        logger.info("Animation Completed");
      }
      break;
      case AnimationStatus.forward : {
        logger.info("Animation Forward");
      }
      break;
      case AnimationStatus.reverse : {
        logger.info("Animation Reverse");
      }
      break;
      case AnimationStatus.dismissed : {
        logger.info("Animation Dismissed");
      }
      break;
    }

  }

  void onClickHomeMenu() {
    Get.offAllNamed("/");
  }

  AnimationController getAnimationController() {
    return _drawerAc;
  }

  void onClickMenu() {
    if (_drawerAc.status != AnimationStatus.completed){
      openDrawer();
    } else {
      closeDrawer();
    }
  }
}
