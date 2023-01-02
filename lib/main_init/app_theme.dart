import 'package:flutter/material.dart';

class AppBasicTheme {
  final appTheme = ThemeData(
      fontFamily: "Noto Sans KR",
      accentColor: const Color.fromRGBO(10, 10, 10, 1.0),
      secondaryHeaderColor: const Color.fromRGBO(10, 10, 10, 1.0),
      // primarySwatch: Colors.indigo,
      primaryColor: Color.fromRGBO(10, 10, 10, 1.0),
      // primaryColorLight: Color.fromRGBO(250, 250, 250, 1.0),
      // primaryColorDark: Color.fromRGBO(10, 10, 10, 1.0),
      focusColor: Colors.black,
      //  hoverColor: ,
      //  shadowColor: ,
      //  canvasColor: ,
      //  scaffoldBackgroundColor: ,
      //  bottomAppBarColor: ,
      cardColor: Color.fromARGB(255, 223, 223, 223),
      //  dividerColor: ,
      //  highlightColor: ,
      splashColor: Colors.black,
      //  selectedRowColor: ,
      //  unselectedWidgetColor: ,
      //  disabledColor: ,
      //  secondaryHeaderColor: ,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      //  dialogBackgroundColor: ,
      //  indicatorColor: ,
      //  hintColor: ,
      //  errorColor: ,
      //  toggleableActiveColor: ,

      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black),
        elevation: 0,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
      ));
}
