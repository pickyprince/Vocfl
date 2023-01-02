import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/single_words_set.dart';
import '../../domain/repositories/words_set_repositories.dart';
import '../../../../core/error/failures.dart';

class Params {
  SingleWordsSet singleWordsSet;
  Params({required this.singleWordsSet});
}

class AddSingleWordsSetToRepository implements UseCase<void, Params> {
  final WordsSetRepository repository;

  AddSingleWordsSetToRepository(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.addWordsSetToRepository(params.singleWordsSet);
  }
}
