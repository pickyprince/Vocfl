import '../../domain/entities/wrong_word.dart';

class WrongWordModel extends WrongWord {
  WrongWordModel(
      {required super.originalSpelling,
      required super.wCounts,
      required super.time});

  //from json
  factory WrongWordModel.fromJson(Map<String, dynamic> json) {
    return WrongWordModel(
      originalSpelling: json['originalSpelling'],
      wCounts: json['wCounts'],
      time: json['time'],
    );
  }
  //to json
  Map<String, dynamic> toJson() {
    return {
      "originalSpelling": originalSpelling,
      "wCounts": wCounts,
      "time": time,
    };
  }
}
