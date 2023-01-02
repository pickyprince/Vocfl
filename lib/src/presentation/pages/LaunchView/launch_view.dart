import 'package:Vocfl/main_init/ini_loader.dart';
import 'package:Vocfl/features/wss_management/presentation/pages/HomeView/home_view_main.dart';
import 'package:Vocfl/features/wss_management/presentation/widgets/loading_view.dart';
import 'package:Vocfl/features/wss_management/presentation/widgets/router.dart';
import 'package:flutter/material.dart';

class LaunchView extends StatelessWidget {
  const LaunchView({super.key});
  @override
  Widget build(BuildContext context) {
    init().then((value) async {
      await Future.delayed(Duration(seconds: 2));
      AppRouter.replaceRouteTo(
          context, HomeView.routeName, ScreenArguments(args: {}));
    });
    return LoadingView();
  }
}

Future<void> init() async {
  await vocflInit();
}
