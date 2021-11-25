import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fometic/utils/strutils/constants.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search",
            suffixIcon: InkWell(
              onTap: () {
                logger.info("Click Search");
              },
              child: Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset("assets/icons/Search.svg",
                  allowDrawingOutsideViewBox: false,
                  height: 30,
                  width: 30,),
                  ),
            ),)
          ),
        );
  }
}
