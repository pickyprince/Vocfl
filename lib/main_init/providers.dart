import 'package:Vocfl/features/wss_management/presentation/providers/analysis_provider.dart';

import '../features/wss_management/presentation/providers/filter_option_provider.dart';
import '../features/wss_management/presentation/providers/multiple_words_provider.dart';
import '../features/wss_management/presentation/providers/settings-provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../features/wss_management/presentation/providers/test_result_provider.dart';

class VocflProviders {
  static List<SingleChildWidget> vocflProviders = [
    ChangeNotifierProvider(
      create: (context) => Settings(),
    ),
    ChangeNotifierProvider(
      create: (context) => VocflDataProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AnalysisProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TestResultProvider(DateTime.now()),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeFilterProvider(),
    ),
  ];
}
