import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/single_words_set.dart';
import '../../domain/repositories/words_set_repositories.dart';
import '../../../../core/error/failures.dart';
import '../entities/word.dart';

class Params {
  int wordIndex;
  SingleWordsSet wordsSet;
  Params({required this.wordIndex, required this.wordsSet});
}

class DeleteWordFromRepository implements UseCase<void, Params> {
  final WordsSetRepository repository;

  DeleteWordFromRepository(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteWord(params.wordsSet, params.wordIndex);
  }
}
