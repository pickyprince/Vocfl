import 'package:Vocfl/features/wss_management/presentation/pages/AnalysisView/analysis_view.dart';
import 'package:Vocfl/features/ws_management/presentation/pages/ws_manager_page/home_view_main.dart';

import '../features/wss_management/presentation/pages/LaunchView/launch_view.dart';
import '../features/wss_management/presentation/pages/ResultView/result_view.dart';
import '../features/wss_management/presentation/pages/WordEditView/word_edit_view.dart';
import '../features/wss_management/presentation/pages/AddDirectView/ws_direct_screen.dart';
import '../features/wss_management/presentation/pages/AddImportView/ws_import_screen.dart';
import '../features/wss_management/presentation/pages/FlashCardView/flash_card_screen.dart';
import '../features/wss_management/presentation/pages/SettingView/setting_screen.dart';
import '../features/wss_management/presentation/pages/WordTestView/word_test_view.dart';
import '../features/wss_management/presentation/pages/WordsSetView/words_set_screen.dart';
import 'package:flutter/material.dart';

class VocflRoutes {
  static Map<String, Widget Function(BuildContext)> vocflRoutes = {
    SettingScreen.routeName: (context) => SettingScreen(),
    ImportView.routeName: (context) => ImportView(),
    AddWordsSet.routeName: (context) => AddWordsSet(),
    WordsSetScreen.routeName: (context) => WordsSetScreen(),
    FlashCard.routeName: (context) => FlashCard(),
    WordsEditView.routeName: (context) => WordsEditView(),
    WordTestView.routeName: (context) => WordTestView(),
    ResultView.routeName: (context) => ResultView(),
    AnalysisView.routeName: (context) => AnalysisView(),
    HomeView.routeName: (context) => HomeView(),
  };
}
