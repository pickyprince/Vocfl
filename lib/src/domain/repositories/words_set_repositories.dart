import 'package:dartz/dartz.dart';
import '../../domain/entities/multiple_words_set.dart';
import '../../domain/entities/single_words_set.dart';
import '../../../../core/error/failures.dart';
import '../entities/word.dart';

abstract class WordsSetRepository {
  Future<Either<Failure, MultipleWordsSet>> getEveryWordsSets();
  Future<Either<Failure, SingleWordsSet>> getOneWordsSet(String wordSetsId);
  Future<Either<Failure, void>> addWordsSetToRepository(SingleWordsSet item);
  Future<Either<Failure, void>> addMultipleWordsSetsToRepository(
      MultipleWordsSet items);
  Future<Either<Failure, void>> deleteWordsSet(String wordSetsId);
  Future<Either<Failure, void>> updateWordsSet(SingleWordsSet item);

  Future<Either<Failure, void>> addWord(SingleWordsSet wordSetsId, Word word);
  Future<Either<Failure, void>> deleteWord(
      SingleWordsSet wordSetsId, int wordIndex);
  Future<Either<Failure, void>> updateWord(
      SingleWordsSet wordsSetsId, int wordIndex, Word word);
}
