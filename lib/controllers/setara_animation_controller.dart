import 'package:flutter/animation.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class SetaraAnimationController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _drawerAc;

  bool isInitialized = false;
  bool isAnimating = false;
  double tickler = 0.0;

  @override
  void onInit() {
    super.onInit();
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
  }

  void _animatingOnProgress() {
    logger.info("_animatingOnProgress ${_drawerAc.value}");
  }

  void _updateStatus(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed : {
        Future.delayed(Duration(milliseconds: 200));
        //_drawerAc.reverse();
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

  @override
  void dispose() {
    logger.info("DISPOSED");
    _drawerAc.removeStatusListener(_updateStatus);
    _drawerAc.removeListener(_animatingOnProgress);
    _drawerAc.dispose();
    super.dispose();
  }

  void forward() {
    if(_drawerAc.status == AnimationStatus.completed || _drawerAc.status == AnimationStatus.dismissed  ) {
      ///start AnimationTickler from 0.0 to 1.0
      _drawerAc.forward();
    }
  }

  void reverse() {
    if(_drawerAc.status == AnimationStatus.completed || _drawerAc.status == AnimationStatus.dismissed  ) {
      ///reversing the AnimationController tickler from 1.0 to 0.0
      _drawerAc.reverse(from: 1.0);
    }
  }
}
