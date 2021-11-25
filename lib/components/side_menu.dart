import 'package:flutter/material.dart';
import 'package:fometic/utils/strutils/constants.dart';

import 'drawer_list_tile.dart';

typedef SideMenuCallback = void Function(String menuName, String actionPushed);

class SideMenu extends StatelessWidget {
  final SideMenuCallback? onClickMenu;

  const SideMenu({Key? key, this.onClickMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      //color: Theme.of(context).appBarTheme.backgroundColor,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Home",
            svgSrc: "assets/icons/menu_home.svg",
            press: () => onClickMenu!("Home", "OnClick"),
          ),
          const SizedBox(
            height: minHeightPadding,
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () => onClickMenu!("Dashboard", "OnClick"),
          ),
          const SizedBox(
            height: minHeightPadding,
          ),
          DrawerListTile(
            title: "Manajemen Acara",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () => onClickMenu!("Agenda", "OnClick"),
          ),
          const SizedBox(
            height: minHeightPadding,
          ),
          DrawerListTile(
            title: "Manajemen Aset",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          const SizedBox(
            height: minHeightPadding,
          ),
          DrawerListTile(
            title: "Team Management",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => onClickMenu!("Team", "OnClick"),
          ),
          const SizedBox(
            height: minHeightPadding,
          ),
          DrawerListTile(
            title: "Pendaftaran Anggota",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          const SizedBox(
            height: minHeightPadding,
          ),
          DrawerListTile(
            title: "Laporan",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          const SizedBox(
            height: minHeightPadding,
          ),
          DrawerListTile(
            title: "Pengaturan",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
          const SizedBox(
            height: minHeightPadding,
          ),
          DrawerListTile(
            title: "Change Theme",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => onClickMenu!("Theme", "OnClick"),
          ),
        ],
      ),
    ));
  }
}
