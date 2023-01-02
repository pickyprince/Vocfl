import 'package:equatable/equatable.dart';

class WrongWord extends Equatable {
  final String originalSpelling;
  final String trimmedSpelling;
  final int wCounts;
  final String time;
  WrongWord({
    required this.originalSpelling,
    required this.wCounts,
    required this.time,
  }) : trimmedSpelling =
            originalSpelling.trim().toLowerCase().replaceAll(RegExp(r" "), "");

  @override
  List<Object?> get props => [trimmedSpelling];
}
