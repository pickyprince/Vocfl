import 'package:Vocfl/core/error/failures.dart';
import 'package:Vocfl/core/usecases/usecase.dart';
import 'package:Vocfl/features/wss_management/domain/repositories/ini_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/ini.dart';

class Params {
  Ini ini;
  Params({required this.ini});
}

class UpdateIni implements UseCase<void, Params> {
  final IniRepository repository;
  UpdateIni({required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.updateIni(params.ini);
  }
}
