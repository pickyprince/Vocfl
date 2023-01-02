import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/multiple_words_set.dart';
import '../../domain/repositories/words_set_repositories.dart';
import '../../../../core/error/failures.dart';

class NoParams {}

class GetEveryWordsSets implements UseCase<MultipleWordsSet, NoParams> {
  final WordsSetRepository repository;
  GetEveryWordsSets(this.repository);

  @override
  Future<Either<Failure, MultipleWordsSet>> call(NoParams noParams) async {
    return await repository.getEveryWordsSets();
  }
}
