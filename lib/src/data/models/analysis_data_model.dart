import 'package:Vocfl/features/wss_management/data/models/right_word_model.dart';
import 'package:Vocfl/features/wss_management/data/models/wrong_word_model.dart';
import 'package:Vocfl/features/wss_management/domain/entities/analysis_data.dart';
import 'package:Vocfl/features/wss_management/domain/entities/right_word.dart';
import 'package:Vocfl/features/wss_management/domain/entities/wrong_word.dart';

import '../../data/models/single_words_set_model.dart';
import '../../domain/entities/multiple_words_set.dart';

import '../../domain/entities/single_words_set.dart';

class AnalysisDataModel extends AnalysisData {
  AnalysisDataModel({required super.rWords, required super.wWords});
  factory AnalysisDataModel.fromJson(Map<String, dynamic> json) {
    List<WrongWordModel> twWords = [];
    List<RightWordModel> trWords = [];
    for (Map<String, dynamic> wWord in json["wWords"]) {
      twWords.add(WrongWordModel.fromJson(wWord));
    }
    for (Map<String, dynamic> rWord in json["rWords"]) {
      trWords.add(RightWordModel.fromJson(rWord));
    }
    return AnalysisDataModel(rWords: trWords, wWords: twWords);
  }
  //to json
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> wTempWords = [];
    List<Map<String, dynamic>> rTempWords = [];

    for (WrongWord wWord in wWords) {
      wTempWords.add(WrongWordModel(
        originalSpelling: wWord.originalSpelling,
        wCounts: wWord.wCounts,
        time: wWord.time,
      ).toJson());
    }

    for (RightWord rWord in rWords) {
      rTempWords.add(RightWordModel(
        originalSpelling: rWord.originalSpelling,
        rCounts: rWord.rCounts,
        time: rWord.time,
      ).toJson());
    }
    return {
      'rWords': rTempWords,
      'wWords': wTempWords,
    };
  }
}
