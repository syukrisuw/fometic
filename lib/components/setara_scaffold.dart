import 'package:flutter/material.dart';
import 'package:fometic/components/side_menu.dart';
import 'package:fometic/utils/responsive/responsive.dart';
import 'package:get/get.dart';

typedef OnClickMenuCallback = void Function(String menuName, String actionPushed);
typedef OnPressFABCallback = void Function();

class SetaraScaffold extends StatelessWidget {
  final OnClickMenuCallback? onClickMenu;
  final OnPressFABCallback? onPressedFAB;
  final Widget body;
  final GetxController controller;
  final bool resizeToAvoidBottomInset;
  final Key scaffoldKey;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;

  const SetaraScaffold(
      {Key? key,
      required this.body,
      required this.controller,
      required this.scaffoldKey,
      this.resizeToAvoidBottomInset = true,
      this.appBar,
      this.floatingActionButton,
      this.onClickMenu,
      this.onPressedFAB})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: body,
      drawer: Responsive.isDesktop(context)
          ? null
          : SideMenu(onClickMenu: onClickMenu),
      appBar: appBar,
      floatingActionButton: Responsive.isDesktop(context)
          ? null
          : FloatingActionButton.small(
              child: const Icon(Icons.menu), onPressed: onPressedFAB),
    );
  }
}
