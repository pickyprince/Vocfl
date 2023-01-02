import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/ini.dart';

abstract class IniRepository {
  Future<Either<Failure, Ini>> getIni();
  Future<Either<Failure, void>> updateIni(Ini ini);
}
