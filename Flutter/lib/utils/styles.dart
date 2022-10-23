import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const primaryColor = Color(0XFF44a551);
  // static const secondaryColor = Color(0XFF2C9523);

  // static const pageTitle =
  //     TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600);
  static const generalBody = TextStyle(fontSize: 13, color: Colors.black);
  static const primaryTextBody = TextStyle(fontSize: 13, color: Color(0XFF44a551));
  // static const generalBoldBody =
  //     TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600);
  static const placeHolder = TextStyle(fontSize: 13, color: Colors.grey);
  static TextStyle get subBody => GoogleFonts.openSans(fontSize: 16,);
  static TextStyle get largeBoldBody => GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold);

  // static const lightWhite = TextStyle(fontSize: 13, color: Color(0XFFFFFFFF));
  static const boldWhite = TextStyle(
      fontSize: 14, color: Color(0XFFFFFFFF), fontWeight: FontWeight.w600);
  // static const normalWhite = TextStyle(fontSize: 12, color: Color(0XFFFFFFFF));
  // static const smallWhite = TextStyle(fontSize: 10, color: Color(0XFFFFFFFF));
  // static const smallGrey = TextStyle(fontSize: 10, color: Colors.grey);
  // static const generalBodyGrey = TextStyle(fontSize: 12, color: Colors.grey);

  // static const sidebarMenuIcon = 18.0;
  // static var lightBg = Colors.grey[200];

  // static const extraSmallBody = TextStyle(fontSize: 10);
}
