import 'dart:ui';

typedef MenuItemCallback = void Function();

class StrMenuItem {
  final String menuName;
  final String? menuTitle;
  final String? menuSubTitle;
  final String? menuIconAssetURI;
  final Color? color;
  final MenuItemCallback? menuItemCallback;

  const StrMenuItem({required this.menuName, this.menuTitle, this.menuSubTitle,
  this.menuIconAssetURI, this.color, this.menuItemCallback});

}