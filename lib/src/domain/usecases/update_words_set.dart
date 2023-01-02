import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/single_words_set.dart';
import '../../domain/repositories/words_set_repositories.dart';
import '../../../../core/error/failures.dart';

class Params {
  SingleWordsSet updatedWS;
  Params({required this.updatedWS});
}

class UpdateWordsSet implements UseCase<void, Params> {
  final WordsSetRepository repository;

  UpdateWordsSet(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.updateWordsSet(params.updatedWS);
  }
}
