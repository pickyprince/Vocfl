import 'package:equatable/equatable.dart';
import './word.dart';

class SingleWordsSet extends Equatable {
  final String title;
  final String id;
  final List<Word> words;
  final DateTime date;
  final String wordType;

  SingleWordsSet({
    required this.title,
    required this.id,
    required this.words,
    required this.wordType,
  }) : date = DateTime.now();

  @override
  List<Object?> get props {
    return [title, id, words, date];
  }
}
