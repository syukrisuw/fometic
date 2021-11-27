import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const opacityMaskColor = Color(0xB2E8E8E8);
const maxIconHeight = 14.0;
const minPadding = 2.0;
const minPageContentPadding = 20.0;
const minElevation = 3.0;
const minFormOuterPadding = formContentHeight;
const minContentPadding = 5.0;
const minFormContentPadding = formContentHeight / 2;
const minBorderRadius= 2.0;
const minButtonBorderRadius= 5.0;
const medButtonBorderRadius= 15.0;
const minHeightPadding = 2.0;
const borderWidthSmall = 2.0;
const borderWidthMedium = 8.0;
const borderWidthThick = 16.0;
const borderRadiusSmall = 5.0;
const borderRadiusMedium = 10.0;
const borderRadiusLarge = 20.0;
const defaultPadding = 16.0;
const formStylePadding = 8.0;
const formContentRowSmallPadding = 4.0;
const formContentRowPadding = 16.0;
const formContentColPadding = 8.0;
const formHeadContentPadding = 5.0;
const formTitleTextSize = 24.0;
const formContentTextSize = 10.0;
const formContentHeight = 12.0;
const formTitlePadding = 2.0;
const formTitleTextHeight = 25.0;
const formTitleMinHeight = 28.0;
const minScaleFactor = 0.5;
const smallScaleFactor = 1.5;
const medScaleFactor = 2.5;
const largeScaleFactor = 3.5;

const textLogin = "Login";
const textRegister = "Register";
const formTitleTextStyle = TextStyle(fontSize: formTitleTextSize);
const formContentlabelStyle =
    TextStyle(fontSize: formContentTextSize, color: Colors.black);

TextStyle formHeaderLabelStyle(BuildContext context) {
  if (Theme.of(context).textTheme.headline1 != null) {
    return Theme.of(context).textTheme.headline1!;
  } else {
    return const TextStyle( fontSize: formTitleTextHeight , color: Colors.purple);
  }
}

TextStyle formContentLabelStyle(BuildContext context) {
  if (Theme.of(context).textTheme.bodyText1 != null) {
    return Theme.of(context).textTheme.bodyText1!;
  } else {
    return const TextStyle( fontSize: formContentTextSize , color: Colors.purple);
  }
}

const formContentInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.zero,
    border: OutlineInputBorder(),
    hintText: "Nama Transaksi",
    labelText: "Nama Transaksi",
    labelStyle: formContentlabelStyle);

BoxDecoration formHeaderBoxDecoration(BuildContext context) {
  return BoxDecoration(
    border: Border.all(
      color: Theme.of(context).colorScheme.primaryVariant,
      width: borderWidthSmall,
    ),
    borderRadius:
        const BorderRadius.all(Radius.circular(minFormContentPadding / 2)),
  );
}

BoxDecoration formContentBoxDecoration(BuildContext context) {
  return BoxDecoration(
    border: Border.all(
      color: Theme.of(context).colorScheme.secondaryVariant,
      width: borderWidthSmall,
    ),
    borderRadius:
        const BorderRadius.all(Radius.circular(minFormContentPadding / 2)),
  );
}


const formSizeBoxSpacer =  SizedBox(
width: minFormContentPadding,
height: minFormContentPadding,
);
