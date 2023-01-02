import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/single_words_set.dart';
import '../../domain/repositories/words_set_repositories.dart';

class Params {
  final String wordsSetsId;
  Params({required this.wordsSetsId});
}

class GetOneWordsSet implements UseCase<SingleWordsSet, Params> {
  WordsSetRepository repository;
  GetOneWordsSet(this.repository);
  @override
  Future<Either<Failure, SingleWordsSet>> call(Params params) async {
    return await repository.getOneWordsSet(params.wordsSetsId);
  }
}
