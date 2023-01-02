import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/repositories/words_set_repositories.dart';
import '../../../../core/error/failures.dart';

class Params {
  String deleteId;
  Params({required this.deleteId});
}

class DeleteWordsSet implements UseCase<void, Params> {
  final WordsSetRepository repository;

  DeleteWordsSet(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteWordsSet(params.deleteId);
  }
}
