import 'dart:convert';

import '../../data/models/word_model.dart';

import '../../domain/entities/single_words_set.dart';
import '../../domain/entities/word.dart';

class SingleWordsSetModel extends SingleWordsSet {
  SingleWordsSetModel(
      {required super.title,
      required super.id,
      required super.words,
      required super.wordType});

  //from json
  factory SingleWordsSetModel.fromJson(Map<String, dynamic> json) {
    List<WordModel> objs = [];
    for (Map<String, dynamic> jsonWord in json['words']) {
      objs.add(WordModel.fromJson(jsonWord));
    }
    return SingleWordsSetModel(
      title: json['title'],
      id: json['id'],
      words: objs,
      wordType: json['wordType'],
    );
  }
  //to json
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> wordMapList = [];
    for (Word word in words) {
      wordMapList.add(WordModel(
              meaning: word.meaning,
              spelling: word.spelling,
              importance: word.importance,
              wCounts: word.wCounts)
          .toJson());
    }
    return {
      "title": title,
      "id": id,
      "words": wordMapList,
      "wordType": wordType,
    };
  }
}
