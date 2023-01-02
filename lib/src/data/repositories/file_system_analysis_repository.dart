import 'package:Vocfl/features/wss_management/data/datasources/local_data_source.dart';
import 'package:Vocfl/features/wss_management/domain/entities/analysis_data.dart';
import 'package:Vocfl/core/error/failures.dart';
import 'package:Vocfl/features/wss_management/domain/repositories/analysis_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/right_word.dart';
import '../../domain/entities/wrong_word.dart';
import '../models/analysis_data_model.dart';
import '../models/right_word_model.dart';

class FileSystemAnalysisRepository implements AnalysisRepository {
  final LocalDataSource localDataSource;

  FileSystemAnalysisRepository({required this.localDataSource});

  @override
  Future<Either<Failure, AnalysisData>> getAnalysisData() async {
    try {
      AnalysisDataModel model = AnalysisDataModel.fromJson(
          await localDataSource.readAnalysisDataFile());
      List<RightWord> rw = [];
      List<WrongWord> ww = [];
      for (final rword in model.rWords) {
        rw.add(RightWord(
            originalSpelling: rword.originalSpelling,
            rCounts: rword.rCounts,
            time: rword.time));
      }

      for (final wword in model.wWords) {
        ww.add(WrongWord(
            originalSpelling: wword.originalSpelling,
            wCounts: wword.wCounts,
            time: wword.time));
      }
      AnalysisData result = AnalysisData(
        rWords: rw,
        wWords: ww,
      );
      return Right(result);
    } on DirectoryException {
      return Left(DataSourceFailure());
    } on FileReadException {
      return Left(FileReadFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateAnalysisData(AnalysisData data) async {
    try {
      Map<String, dynamic> analysisMap =
          AnalysisDataModel(rWords: data.rWords, wWords: data.wWords).toJson();

      final result = await localDataSource.writeAnalysisDataFile(analysisMap);

      return Right(result);
    } on DirectoryException {
      return Left(DataSourceFailure());
    } on FileWriteException {
      return Left(FileWriteFailure());
    }
  }
}
