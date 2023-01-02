import '../../domain/entities/word.dart';
import 'package:flutter/material.dart';

class WordModel extends Word {
  WordModel({
    required super.spelling,
    required super.meaning,
    super.importance = 0.0,
    super.wCounts = 0,
  });

  //from json
  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
        meaning: json['meaning'],
        spelling: json['spelling'],
        importance: json['importance'],
        wCounts: json['wCounts']);
  }
  //to json
  Map<String, dynamic> toJson() {
    return {
      "spelling": spelling,
      "meaning": meaning,
      "importance": importance,
      "wCounts": wCounts,
    };
  }
}
