import 'package:flutter/material.dart';
import 'package:fometic/utils/responsive/responsive.dart';
import 'package:fometic/utils/strutils/constants.dart';

class ProfileCard extends StatelessWidget {
  final Function logOutPressed;
  const ProfileCard({
    Key? key, required this.logOutPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Angelina Jolie"),
            ),
          Icon(Icons.keyboard_arrow_down),
          Center(
            child:IconButton(
              onPressed: () => logOutPressed(),
              icon: Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}