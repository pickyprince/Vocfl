import 'package:Vocfl/core/usecases/usecase.dart';
import 'package:Vocfl/features/wss_management/domain/entities/analysis_data.dart';
import 'package:Vocfl/features/wss_management/domain/repositories/analysis_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class NoParams {}

class GetAnalysisData extends UseCase<AnalysisData, NoParams> {
  final AnalysisRepository repository;

  GetAnalysisData(this.repository);

  @override
  Future<Either<Failure, AnalysisData>> call(NoParams params) {
    return repository.getAnalysisData();
  }
}
