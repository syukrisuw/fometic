import 'package:get/get.dart';
import 'package:fometic/components/profile_card.dart';
import 'package:fometic/components/search_field.dart';
import 'package:fometic/controllers/main_page_controller.dart';
import 'package:fometic/utils/responsive/responsive.dart';
import 'package:flutter/material.dart';

class Header extends GetView<MainPageController> {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: (){},//controller.controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: const SearchField()),
        ProfileCard( logOutPressed: () {},)
      ],
    );
  }
}




