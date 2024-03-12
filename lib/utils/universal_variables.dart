import 'package:flutter/material.dart';

class UniversalVariables {
  static const Color blueColor = Color(0xff0077d7);
  static const Color lightBlueColor = Color(0xff00b6f3);
  static const Color darkBlueColor = Color(0xff0184dc);
  static const Color paleBlueColor = Color(0xffb3e5fc);
  static const Color navyBlueColor = Color(0xff001f3f);
  static const Color carolinaBlueColor = Color(0xff7ba9d1);
  static const Color columbiaBlueColor = Color(0xffc2e3f6);
  static const Color aliceBlueColor = Color(0xfff0f8ff);
  static const Color marineBlueColor = Color(0xff4f86c6);

  static const Color greyColor = Color(0xff8f8f8f);
  static const Color userCircleBackground = Color(0xff2b2b33);
  static const Color onlineDotColor = Color(0xff46dc64);
  static const Color separatorColor = Color(0xff272c35);

  static const Color senderColor = Color(0xff2b343b);
  static const Color receiverColor = Color(0xff1e2225);

  static const Gradient fabGradient = LinearGradient(
    colors: [lightBlueColor, darkBlueColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
