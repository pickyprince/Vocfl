import 'package:equatable/equatable.dart';
import '../../domain/entities/single_words_set.dart';

class MultipleWordsSet extends Equatable {
  final List<SingleWordsSet> wordsSetList;

  MultipleWordsSet({
    required this.wordsSetList,
  });

  @override
  List<Object?> get props {
    return [wordsSetList];
  }
}
