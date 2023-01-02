import '../../domain/entities/right_word.dart';

class RightWordModel extends RightWord {
  RightWordModel({
    required super.originalSpelling,
    required super.rCounts,
    required super.time,
  });

  //from json
  factory RightWordModel.fromJson(Map<String, dynamic> json) {
    return RightWordModel(
      originalSpelling: json['originalSpelling'],
      rCounts: json['rCounts'],
      time: json['time'],
    );
  }
  //to json
  Map<String, dynamic> toJson() {
    return {
      "originalSpelling": originalSpelling,
      "rCounts": rCounts,
      "time": time,
    };
  }
}
