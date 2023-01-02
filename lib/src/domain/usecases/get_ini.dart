import 'package:Vocfl/core/error/failures.dart';
import 'package:Vocfl/core/usecases/usecase.dart';
import 'package:Vocfl/features/wss_management/domain/repositories/ini_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/ini.dart';

class NoParams {}

class GetIni implements UseCase<Ini, NoParams> {
  final IniRepository repository;
  GetIni({required this.repository});

  @override
  Future<Either<Failure, Ini>> call(NoParams params) {
    return repository.getIni();
  }
}
