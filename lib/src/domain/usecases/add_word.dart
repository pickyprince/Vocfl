import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/single_words_set.dart';
import '../../domain/repositories/words_set_repositories.dart';
import '../../../../core/error/failures.dart';
import '../entities/word.dart';

class Params {
  Word word;
  SingleWordsSet wordsSet;
  Params({required this.word, required this.wordsSet});
}

class AddWordToRepository implements UseCase<void, Params> {
  final WordsSetRepository repository;

  AddWordToRepository(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.addWord(params.wordsSet, params.word);
  }
}
