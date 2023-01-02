import '../../data/models/single_words_set_model.dart';
import '../../domain/entities/multiple_words_set.dart';

import '../../domain/entities/single_words_set.dart';

class MultipleWordsSetModel extends MultipleWordsSet {
  MultipleWordsSetModel({required super.wordsSetList});
  factory MultipleWordsSetModel.fromJson(List<Map<String, dynamic>> json) {
    List<SingleWordsSetModel> result = [];
    for (Map<String, dynamic> j in json) {
      result.add(SingleWordsSetModel.fromJson(j));
    }
    return MultipleWordsSetModel(wordsSetList: result);
  }
  //to json
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> wset = [];
    for (SingleWordsSet elem in wordsSetList) {
      wset.add(SingleWordsSetModel(
              title: 'title',
              id: elem.id,
              words: elem.words,
              wordType: elem.wordType)
          .toJson());
    }
    return {'wordsSetList': wset};
  }
}
