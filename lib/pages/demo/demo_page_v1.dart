import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fometic/components/setara_bottom_navigation_bar.dart';
import 'package:fometic/controllers/demo_page_controller.dart';
import 'package:fometic/pages/demo/component/setara_menu_item.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class DemoPage extends GetView<DemoPageController> {
  const DemoPage({Key? key}) : super(key: key);

  //List of bottomNavigationItem
  static final List<Icon> items = <Icon>[
    const Icon(
      Icons.menu,
      color: Colors.purple,
    ),
    const Icon(
      Icons.chevron_left,
      color: Colors.blue,
    ),
    const Icon(
      Icons.chevron_right,
      color: Colors.blue,
    ),
    const Icon(
      Icons.settings,
      color: Colors.blue,
    ),
  ];

  //List of menu in Drawer
  static final List<StrMenuItem> menuList = [
    const StrMenuItem(menuName: "Home", menuTitle: "Homey"),
    const StrMenuItem(menuName: "Transaksi", menuTitle: "Transaksiz"),
    const StrMenuItem(menuName: "Profile", menuTitle: "Profiley"),
    const StrMenuItem(menuName: "Setting", menuTitle: "Settingz"),
  ];

  @override
  Widget build(BuildContext context) {
    List<StrMenuItem> menuList = [
      StrMenuItem(
          menuName: "Homey",
          menuTitle: "Home",
          menuItemCallback: controller.onClickHomeMenu),
      const StrMenuItem(menuName: "Transaksi", menuTitle: "Transaksi"),
      const StrMenuItem(menuName: "Profile", menuTitle: "Profile"),
      const StrMenuItem(menuName: "Setting", menuTitle: "Setting"),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
          child: GestureDetector(
            child: Container(
              //margin: const EdgeInsets.all(minPageContentPadding),

                width: double.infinity,
                color: Colors.white,
                child: SafeArea(
                  child: Stack(children: [
                    //Menu Section
                    buildDrawerSection(context),
                    //Content Page Section
                    buildPageSection(context),
                  ]),
                )),
            onTap: controller.onGestureTap,
            onDoubleTap: controller.onGestureDoubleTap,
            onHorizontalDragEnd: (dragDetails) {
              logger.info(
                  "onHorizontalDragUpdate dragDetails.primaryVelocity:${dragDetails.primaryVelocity}");
              if (dragDetails.primaryVelocity! >= 1.0) {
                logger.info(
                    "onHorizontalDragUpdate maybe rigth slide}");
                controller.openDrawer();
              } else {
                logger.info(
                    "onHorizontalDragUpdate maybe left slide}");
                controller.closeDrawer();
              }
            },
          )),
      bottomNavigationBar: SetaraBottomNavigationBar(
        height: 60,
        width: MediaQuery.of(context).size.width,
        items: items,
        menuButtonCallback: controller.onClickMenu,
        color: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).backgroundColor,
      ),
    );
  }

  Widget buildDrawerSection(BuildContext context) {
    return Obx(() => Positioned(
      left: (-1 * minDrawerWidth) +
          (minDrawerWidth * controller.animationTickler.value),
      width: minDrawerWidth,
      //color: const Color(0xFF147200),
      child: Center(
        child: Column(
            children: menuList
                .map(
                  (e) => ListTile(
                title: Text(e.menuTitle ?? e.menuName),
                onTap: e.menuItemCallback ??
                        () {
                      logger.info("Menu ${e.menuTitle} Tapped");
                    },
              ),
            )
                .toList()),
      ),
    ));
  }

  Widget buildPageSection(BuildContext context) {
    final double xOffset = minDrawerWidth + minDrawerPagePadding;
    final double yOffset = minPagePadding;
    const double rotationDegre = 150; //minPageRotation;
    //Theme.of
    //MediaQuery.of
    return AnimatedBuilder(
        animation: controller.getAnimationController(),
        child: Obx(()=>Container(
          //width: 800.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30*controller.animationTickler.value), bottomLeft: Radius.circular(30*controller.animationTickler.value)),
          ),

          child: Center(
              child: Container(
                  width: 150.0,
                  height: 400.0,
                  padding: const EdgeInsets.all(40),
                  color: Colors.red,
                  child: const Center(
                    child: Text('Whee!'),
                  ))),
        ),),
        builder: (BuildContext context, Widget? child) {
          return Obx(() => Transform(
            alignment: Alignment.centerRight,
            transform: Matrix4.identity()
              ..scale(1.1,1.1,1.1)    //make a bit larger than original
              ..setEntry(3, 2, 0.001 * controller.animationTickler.value)
              ..setEntry(0, 3, 1 * controller.animationTickler.value)
              ..rotateY((rotationDegre / 360) *
                  pi *
                  controller.animationTickler.value),
            child: child,
          ));
        });
  }
}
//
// class AnimatedDrawerBuilder extends StatelessWidget {
//   const AnimatedDrawerBuilder({
//     Key? key,
//     required this.animation,
//     required this.showFrontSide,
//     required this.frontBuilder,
//     required this.backBuilder,
//   }) : super(key: key);
//   final Animation<double> animation;
//   final bool showFrontSide; // we'll see how to use this later
//   final WidgetBuilder frontBuilder;
//   final WidgetBuilder backBuilder;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, _) {
//         // this boolean tells us if we're on the first or second half of the animation
//         final isAnimationFirstHalf = animation.value.abs() < 0.5;
//         // decide which page we need to show
//         final child =
//             isAnimationFirstHalf ? frontBuilder(context) : backBuilder(context);
//         // map values between [0, 1] to values between [0, pi]
//         final rotationValue = animation.value * pi;
//         // calculate the correct rotation angle depening on which page we need to show
//         final rotationAngle =
//             animation.value > 0.5 ? pi - rotationValue : rotationValue;
//         return Transform(
//           transform: Matrix4.rotationY(rotationAngle),
//           child: child,
//           alignment: Alignment.center,
//         );
//       },
//     );
//   }
// }
