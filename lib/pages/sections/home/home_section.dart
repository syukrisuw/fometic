import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fometic/utils/responsive/responsive.dart';
import 'package:fometic/utils/strutils/constants.dart';

class HomeSection extends StatelessWidget {
  double textSize = 40.0;

  TextStyle animatedTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple);
  TextStyle nonAnimatedTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFF3E3C3C));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              color: opacityMaskColor,
              child: Image.asset("assets/images/hero-bg.jpg",
              color: const Color.fromRGBO(255, 255, 255, 0.5),
              colorBlendMode: BlendMode.modulate,),
            ),

          Positioned(
              top: MediaQuery.of(context).size.height/2 + 50,
              left: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width/6 + 10 : 10,
              child: Wrap(
                direction: Axis.horizontal,
                textDirection: Directionality.of(context),
                children: <Widget>[
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText("Berita ", textStyle: animatedTextStyle),
                      TyperAnimatedText("Analisa ", textStyle: animatedTextStyle),
                      TyperAnimatedText("Statistic ", textStyle: animatedTextStyle),
                      TyperAnimatedText("Prediksi ", textStyle: animatedTextStyle),
                      TyperAnimatedText("Review ", textStyle: animatedTextStyle),
                    ],
                  ),
                  Text(" Sepakbola Indonesia dan Dunia", style: nonAnimatedTextStyle),
                ],
              ),),
        ],
      ));
  }
}
