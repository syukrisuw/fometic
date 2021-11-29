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
  DemoPage({Key? key}) : super(key: key);

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

  List<StrMenuItem> menuList = [
    const StrMenuItem(
      menuName: "Page1",
      menuTitle: "Page1 Title",
    ),
    const StrMenuItem(menuName: "Page2", menuTitle: "Page2 Title"),
    const StrMenuItem(menuName: "Page3", menuTitle: "Page3 Title"),
    const StrMenuItem(menuName: "Page4", menuTitle: "Page4 Title"),
    const StrMenuItem(menuName: "Page5", menuTitle: "Page5 Title"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
          child: GestureDetector(
        child: Stack(
          children: [
            buildDrawerSection(context),
            buildPageSection(context),
          ],
        ),
        onTap: controller.onGestureTap,
        onDoubleTap: controller.onGestureDoubleTap,
        onHorizontalDragEnd: (dragDetails) {
          logger.info(
              "onHorizontalDragUpdate dragDetails.primaryVelocity:${dragDetails.primaryVelocity}");
          if (dragDetails.primaryVelocity! >= 1.0) {
            logger.info("onHorizontalDragUpdate maybe rigth slide}");
            controller.openDrawer();
          } else {
            logger.info("onHorizontalDragUpdate maybe left slide}");
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
    double _pageWidth = MediaQuery.of(context).size.width;
    double _pageHeight = MediaQuery.of(context).size.height;
    List<Widget> pageList = <Widget>[
      Container(
        //Page 1
        color: Colors.blue,
        width: _pageWidth,
        height: _pageHeight,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Container(
                  color: Colors.blue.shade800,
                  child: SizedBox(
                      width: _pageWidth / 2,
                      height: _pageHeight / 4,
                      child: const Center(child: Text("Page 1")))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 1"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 2"),
                    ),
                  ),
                ],
              ),
            ])),
      ),
      Container(
        //Page 2
        color: Colors.red,
        width: _pageWidth,
        height: _pageHeight,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Container(
                  color: Colors.red.shade800,
                  child: SizedBox(
                      width: _pageWidth / 2,
                      height: _pageHeight / 4,
                      child: const Center(child: Text("Page 2")))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 1"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 2"),
                    ),
                  ),
                ],
              ),
            ])),
      ),
      Container(
        //Page 3
        color: Colors.green,
        width: _pageWidth,
        height: _pageHeight,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Container(
                  color: Colors.green.shade800,
                  child: SizedBox(
                      width: _pageWidth / 2,
                      height: _pageHeight / 4,
                      child: const Center(child: Text("Page 3")))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 1"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 2"),
                    ),
                  ),
                ],
              ),
            ])),
      ),
      Container(
        //Page 4
        color: Colors.purple,
        width: _pageWidth,
        height: _pageHeight,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Container(
                  color: Colors.purple.shade800,
                  child: SizedBox(
                      width: _pageWidth / 2,
                      height: _pageHeight / 4,
                      child: const Center(child: Text("Page 4")))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 1"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 2"),
                    ),
                  ),
                ],
              ),
            ])),
      ),
      Container(
        //Page 5
        color: Colors.orange,
        width: _pageWidth,
        height: _pageHeight,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Container(
                  color: Colors.orange.shade800,
                  child: SizedBox(
                      width: _pageWidth / 2,
                      height: _pageHeight / 4,
                      child: const Center(child: Text("Page 5")))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 1"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 1"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 1 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 2 row 2"),
                    ),
                  ),
                  SizedBox(
                    width: _pageWidth / 6,
                    height: _pageHeight / 4,
                    child: Container(
                      color: Colors.blue.shade800,
                      child: const Text("Page 1, col 3 row 2"),
                    ),
                  ),
                ],
              ),
            ])),
      ),
    ];

    Widget toBeAnimatedWidget = Container(
        child: Stack(
      children: pageList,
    ));

    final double xOffset = minDrawerWidth + minDrawerPagePadding;
    final double yOffset = minPagePadding;
    const double rotationDegre = 150; //minPageRotation;
    //Theme.of
    //MediaQuery.of

    return AnimatedBuilder(
        animation: controller.getAnimationController(),
        child: Container(
            //width: 800.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(30 * controller.animationTickler.value),
                  bottomLeft:
                      Radius.circular(30 * controller.animationTickler.value)),
            ),
            child: Obx(
              () => IndexedStack(
                index: controller.selectedPageIndex.value,
                children: pageList,
              ),
            )),
        builder: (BuildContext context, Widget? child) {
          return Stack(children: [
            Obx(
              () => Transform(
                alignment: Alignment.topRight,
                transform: Matrix4.identity() //move in x direction
                  ..scale(
                      1 - 0.4 * controller.animationTickler.value,
                      1 - 0.4 * controller.animationTickler.value,
                      1 - 0.4 * controller.animationTickler.value),
                // ..setEntry(0,3,1 * controller.animationTickler.value)
                // ..setEntry(1,3,1 * controller.animationTickler.value),
                //make a bit larger than original
                child: pageList[controller.previousPageIndex.value],
              ),
            ),
            Obx(
              () => Transform(
                alignment: Alignment.bottomRight,
                transform: Matrix4.identity()
                  ..scale(
                      1 - 0.4 * controller.animationTickler.value,
                      1 - 0.4 * controller.animationTickler.value,
                      1 - 0.4 * controller.animationTickler.value), //make a bit larger than original
                child: pageList[controller.nextPageIndex.value],
              ),
            ),
            Obx(
              () => Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..scale(
                      1 - 0.2 * controller.animationTickler.value,
                      1 - 0.2 * controller.animationTickler.value,
                      1 - 0.2 * controller.animationTickler.value), //make a bit larger than original
                child: child,
              ),
            ),
          ]);
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
