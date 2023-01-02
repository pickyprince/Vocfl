import 'package:flutter/material.dart';

import '../../../../../wss_management/presentation/widgets/router.dart';
import '../../../../../wss_management/presentation/pages/AddDirectView/ws_direct_screen.dart';

class HomeWordsSetPlusButton extends StatelessWidget {
  const HomeWordsSetPlusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 20,
        child: InkWell(
          onTap: () => AppRouter.pushRouteTo(
            context,
            AddWordsSet.routeName,
            ScreenArguments(args: {}),
          ),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: MediaQuery.of(context).size.height * 0.13,
            child: const Icon(
              Icons.add,
              size: 46,
            ),
          ),
        ),
      ),
    );
  }
}
