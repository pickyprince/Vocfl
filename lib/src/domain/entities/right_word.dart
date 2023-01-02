import 'package:equatable/equatable.dart';

class RightWord extends Equatable {
  final String originalSpelling;
  final String trimmedSpelling;
  final int rCounts;
  final String time;
  RightWord({
    required this.originalSpelling,
    required this.rCounts,
    required this.time,
  }) : trimmedSpelling =
            originalSpelling.trim().toLowerCase().replaceAll(RegExp(r" "), "");

  @override
  List<Object?> get props => [trimmedSpelling];
}
