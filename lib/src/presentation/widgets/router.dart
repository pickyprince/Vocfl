import 'package:flutter/material.dart';

class ScreenArguments {
  Map<String, dynamic> args;
  ScreenArguments({required this.args});
}

class AppRouter {
  static void pushRouteTo(
    BuildContext context,
    String routeName,
    ScreenArguments args,
  ) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: args,
    );
  }

  static void replaceRouteTo(
    BuildContext context,
    String routeName,
    ScreenArguments args,
  ) {
    Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: args,
    );
  }
}
