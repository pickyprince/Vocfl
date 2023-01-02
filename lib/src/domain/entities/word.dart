import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String spelling;
  final String meaning;
  final double importance;
  final int wCounts;

  Word({
    required this.spelling,
    required this.meaning,
    this.importance = 0.0,
    this.wCounts = 0,
  });

  @override
  List<Object?> get props {
    return [
      spelling,
      meaning,
      importance,
      wCounts,
    ];
  }
}
