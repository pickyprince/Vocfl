import 'package:Vocfl/features/wss_management/data/repositories/file_system_ini_repository.dart';
import 'package:Vocfl/features/wss_management/domain/repositories/ini_repository.dart';
import 'package:Vocfl/features/wss_management/domain/usecases/get_analysis_data.dart';
import 'package:Vocfl/features/wss_management/domain/usecases/update_analysis_data.dart';

import '../features/wss_management/data/datasources/local_data_source.dart';
import '../features/wss_management/data/repositories/file_system_analysis_repository.dart';
import '../features/wss_management/data/repositories/file_system_words_set_repository.dart';
import '../features/wss_management/domain/repositories/analysis_repository.dart';
import '../features/wss_management/domain/repositories/words_set_repositories.dart';
import '../features/wss_management/domain/usecases/add_multiple_words_sets_to_repository.dart';
import '../features/wss_management/domain/usecases/add_word.dart';
import '../features/wss_management/domain/usecases/add_words_set_to_repository.dart';
import '../features/wss_management/domain/usecases/delete_words_set.dart';
import '../features/wss_management/domain/usecases/get_every_words_sets.dart';
import '../features/wss_management/domain/usecases/get_ini.dart';
import '../features/wss_management/domain/usecases/get_one_words_set.dart';
import '../features/wss_management/domain/usecases/update_ini.dart';
import '../features/wss_management/domain/usecases/update_words_set.dart';
import 'package:get_it/get_it.dart';

import '../features/wss_management/domain/usecases/delete_word.dart';
import '../features/wss_management/domain/usecases/update_word.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //
  //Datasources

  sl.registerSingleton<LocalDataSource>(LocalDataSourceImpl());

  //Repositories

  sl.registerSingleton<WordsSetRepository>(
    FilesystemWordsSetRepository(
      localDataSource: sl(),
    ),
  );
  sl.registerSingleton<IniRepository>(
    FileSystemIniRepository(
      localDataSource: sl(),
    ),
  );

  sl.registerSingleton<AnalysisRepository>(
    FileSystemAnalysisRepository(
      localDataSource: sl(),
    ),
  );

  //Usecases

  //WordsSets
  sl.registerSingleton<GetOneWordsSet>(GetOneWordsSet(sl()));
  sl.registerSingleton<GetEveryWordsSets>(GetEveryWordsSets(sl()));
  sl.registerSingleton<AddMultipleWordsSetToRepository>(
      AddMultipleWordsSetToRepository(sl()));
  sl.registerSingleton<AddSingleWordsSetToRepository>(
      AddSingleWordsSetToRepository(sl()));
  sl.registerSingleton<DeleteWordsSet>(DeleteWordsSet(sl()));
  sl.registerSingleton<UpdateWordsSet>(UpdateWordsSet(sl()));

  //Word
  sl.registerSingleton<AddWordToRepository>(AddWordToRepository(sl()));
  sl.registerSingleton<DeleteWordFromRepository>(
      DeleteWordFromRepository(sl()));
  sl.registerSingleton<UpdateWordToRepository>(UpdateWordToRepository(sl()));

  //Ini
  sl.registerSingleton<GetIni>(GetIni(repository: sl()));
  sl.registerSingleton<UpdateIni>(UpdateIni(repository: sl()));

  //Analysis
  sl.registerSingleton<GetAnalysisData>(GetAnalysisData(sl()));
  sl.registerSingleton<UpdateAnalysisData>(UpdateAnalysisData(sl()));

  //! external

  print("의존성 주입 완료");
}
