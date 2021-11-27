

import 'dart:ui';

typedef MenuItemCallback = void Function();

class StrMenuItem {
  final String menuName;
  final String? menuTitle;
  final String? menuSubTitle;
  final String? menuIconURI;
  final Color? color;
  final MenuItemCallback? menuItemCallback;

  StrMenuItem({required this.menuName, this.menuTitle, this.menuSubTitle,
  this.menuIconURI, this.color, this.menuItemCallback});

}