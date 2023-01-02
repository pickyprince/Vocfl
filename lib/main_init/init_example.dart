import 'package:Vocfl/features/wss_management/domain/entities/single_words_set.dart';
import 'package:Vocfl/features/wss_management/domain/entities/word.dart';

import '../features/wss_management/domain/usecases/add_words_set_to_repository.dart';
import './injection_container.dart' as di;

void createExample() {
  di
      .sl<AddSingleWordsSetToRepository>()(
    Params(
      singleWordsSet: SingleWordsSet(
        title: "수능 기초 단어장",
        id: "0_example",
        words: [
          Word(spelling: 'abandon', meaning: '방치하다'),
          Word(spelling: "ability", meaning: "기술"),
          Word(spelling: "able", meaning: "가능한"),
          Word(spelling: "abnormal", meaning: "비정상"),
          Word(spelling: "abroad", meaning: "해외로의"),
          Word(spelling: "abrupt", meaning: "갑작스러운"),
          Word(spelling: "cabin", meaning: "객실, 오두막집"),
          Word(spelling: "calm", meaning: "차분한"),
          Word(spelling: "cancel", meaning: "취소하다"),
          Word(spelling: "candidate", meaning: "후보"),
          Word(spelling: "capable", meaning: "할 가능성이 있는, 할 수 있는"),
          Word(spelling: "capital", meaning: "수도, 돈"),
          Word(spelling: "believe", meaning: "믿다, 믿음"),
          Word(spelling: "bear", meaning: "곰, 참다"),
          Word(spelling: "beg", meaning: "구걸하다"),
          Word(spelling: "behind", meaning: "뒤에"),
          Word(spelling: "because", meaning: "왜냐하면"),
          Word(spelling: "dental", meaning: "치아의"),
          Word(spelling: "denial", meaning: "부정"),
          Word(spelling: "depend", meaning: "의존하다"),
          Word(spelling: "depressed", meaning: "우울한"),
        ],
        wordType: "EN",
      ),
    ),
  )
      .then((value) {
    value.fold((l) {
      print(l.message);
    }, (r) => r);
    return;
  });
}
