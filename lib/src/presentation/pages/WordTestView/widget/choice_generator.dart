import 'dart:math';

import '../../../../domain/entities/word.dart';

class ChoiceGenerator {
  final List<Word> words;
  final currindex;
  ChoiceGenerator(this.words, this.currindex);

  List<int> create() {
    final randomGet = Random();
    List<int> result = [];
    if (words.length == 1) {
      return [1, 1, 1];
    } else if (words.length == 2) {
      if (currindex == 0) {
        return [1, 2, 2];
      }
      return [0, 2, 2];
    } else if (words.length == 3) {
      if (currindex == 0) {
        return [1, 2, 3];
      } else if (currindex == 1) {
        return [0, 2, 3];
      }
      return [0, 1, 3];
    }
    for (int i = 0; result.length < 3; i++) {
      // must be words.length >= 4, 4개 이상
      int randomNumber = randomGet.nextInt(words.length);
      if (result.isNotEmpty) {
        if (!result.contains(randomNumber)) {
          if (randomNumber != currindex) {
            result.add(randomNumber);
          }
        }
      } else {
        if (randomNumber != currindex) {
          result.add(randomNumber);
        }
      }
    }
    print("Choice Generated Successfully");
    return result;
  }
}
