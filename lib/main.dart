import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_init/providers.dart';
import 'main_init/routes.dart';
import 'main_init/app_theme.dart';
import 'main_init/injection_container.dart' as dependency_injector;
import 'src/presentation/pages/LaunchView/launch_view.dart';

void main() async {
  await dependency_injector.init();
  runApp(const VocFl());
}

class VocFl extends StatelessWidget {
  const VocFl({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...VocflProviders.vocflProviders],
      child: MaterialApp(
        theme: AppBasicTheme().appTheme,
        home: const LaunchView(),
        routes: VocflRoutes.vocflRoutes,
      ),
    );
  }
}
