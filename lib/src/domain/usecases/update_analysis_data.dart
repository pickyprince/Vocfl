import 'package:Vocfl/core/usecases/usecase.dart';
import 'package:Vocfl/features/wss_management/domain/entities/analysis_data.dart';
import 'package:Vocfl/features/wss_management/domain/repositories/analysis_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class Params {
  final AnalysisData data;

  Params({required this.data});
}

class UpdateAnalysisData extends UseCase<void, Params> {
  final AnalysisRepository repository;

  UpdateAnalysisData(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.updateAnalysisData(params.data);
  }
}
