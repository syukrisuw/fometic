import 'package:flutter/material.dart';
import 'package:fometic/components/setara_bottom_navigation_bar.dart';
import 'package:fometic/controllers/demo_page_controller.dart';
import 'package:fometic/pages/demo/component/setara_menu_item.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:get/get.dart';

class DemoPage extends GetView<DemoPageController> {
  DemoPage({Key? key}) : super(key: key);

  List<Icon> items = <Icon>[
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

  @override
  Widget build(BuildContext context) {


    List<StrMenuItem> menuList = [
      StrMenuItem(menuName: "Home", menuTitle: "Home"),
      StrMenuItem(menuName: "Transaksi", menuTitle: "Transaksi"),
      StrMenuItem(menuName: "Profile", menuTitle: "Profile"),
      StrMenuItem(menuName: "Setting", menuTitle: "Setting"),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(minPageContentPadding),
          color: Colors.black12,
          child: Stack(children: [
            //Menu Section
            SafeArea(
              child: Container(
                width: 200,
                height:200,
              )
            ),
            buildSection(),]),
        ),
      ),
      bottomNavigationBar: SetaraBottomNavigationBar(
        height: 60,
        width: MediaQuery.of(context).size.width,
        items: items,
        color: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).backgroundColor,
      ),
    );
  }

  Widget buildSection() {
    return Container();
  }
}
