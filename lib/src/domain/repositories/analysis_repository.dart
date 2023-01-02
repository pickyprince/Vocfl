import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/analysis_data.dart';

abstract class AnalysisRepository {
  Future<Either<Failure, AnalysisData>> getAnalysisData();
  Future<Either<Failure, void>> updateAnalysisData(AnalysisData data);
}
