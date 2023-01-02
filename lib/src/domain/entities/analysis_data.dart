import 'package:equatable/equatable.dart';

import 'right_word.dart';
import 'wrong_word.dart';

class AnalysisData extends Equatable {
  final List<RightWord> rWords;
  final List<WrongWord> wWords;

  const AnalysisData({required this.rWords, required this.wWords});

  @override
  List<Object?> get props => [rWords, wWords];
}
