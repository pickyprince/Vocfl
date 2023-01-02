import 'package:flutter/material.dart';

PreferredSizeWidget appBarBuilder(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).backgroundColor,
    titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
    toolbarTextStyle: TextStyle(color: Theme.of(context).primaryColor),
    iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
    title: const Center(
        child: Text("VocFL",
            style: TextStyle(
                fontFamily: "Noto Sans KR",
                fontWeight: FontWeight.bold,
                fontSize: 23))),
    elevation: 0.0,
    actions: [
      Container(
        width: MediaQuery.of(context).size.width * 0.15,
      )
    ],
  );
}
