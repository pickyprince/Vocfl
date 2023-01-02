import 'package:equatable/equatable.dart';

class Ini extends Equatable {
  final bool isFetchedBasicWordsSets;
  final bool isFirstTime;
  Ini({required this.isFetchedBasicWordsSets, required this.isFirstTime});
  @override
  List<Object?> get props => [isFetchedBasicWordsSets, isFirstTime];
}
