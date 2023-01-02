import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/multiple_words_set.dart';
import '../../domain/repositories/words_set_repositories.dart';
import '../../../../core/error/failures.dart';

class Params {
  MultipleWordsSet multipleWordsSets;
  Params({required this.multipleWordsSets});
}

class AddMultipleWordsSetToRepository implements UseCase<void, Params> {
  final WordsSetRepository repository;

  AddMultipleWordsSetToRepository(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository
        .addMultipleWordsSetsToRepository(params.multipleWordsSets);
  }
}
