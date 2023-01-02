import 'package:Vocfl/features/wss_management/data/datasources/local_data_source.dart';
import 'package:Vocfl/features/wss_management/data/models/ini_model.dart';
import 'package:Vocfl/features/wss_management/domain/entities/ini.dart';
import 'package:Vocfl/core/error/failures.dart';
import 'package:Vocfl/features/wss_management/domain/repositories/ini_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class FileSystemIniRepository implements IniRepository {
  final LocalDataSource localDataSource;

  FileSystemIniRepository({required this.localDataSource});

  @override
  Future<Either<Failure, Ini>> getIni() async {
    try {
      IniModel model = IniModel.fromJson(await localDataSource.readIniFile());
      Ini result = Ini(
          isFetchedBasicWordsSets: model.isFetchedBasicWordsSets,
          isFirstTime: model.isFirstTime);
      return Right(result);
    } on LocalDataSourceException {
      return Left(DataSourceFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateIni(Ini ini) async {
    try {
      Map<String, dynamic> iniMap = IniModel(
              isFetchedBasicWordsSets: ini.isFetchedBasicWordsSets,
              isFirstTime: ini.isFirstTime)
          .toJson();

      final result = await localDataSource.writeIniFile(iniMap);

      return Right(result);
    } on LocalDataSourceException {
      return Left(DataSourceFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
