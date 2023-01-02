import 'dart:math';
import 'package:Vocfl/features/wss_management/presentation/pages/WordTestView/widget/choice_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Vocfl/features/wss_management/presentation/pages/ResultView/result_view.dart';
import 'package:Vocfl/features/wss_management/presentation/providers/test_result_provider.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/multiple_words_set.dart';
import '../../../domain/entities/word.dart';
import '../../providers/multiple_words_provider.dart';
import '../../widgets/router.dart';
import '../AddDirectView/widgets/failed_screen.dart';

class WordTestView extends StatefulWidget {
  static const routeName = '/word-test';
  var cardText = '';
  var ans = '';
  var currIndex = 0;
  @override
  State<WordTestView> createState() => _WordTestViewState();
}

class _WordTestViewState extends State<WordTestView> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final setIndex = args.args['setIndex'];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("플래시카드 학습하기")),
      body: Consumer<TestResultProvider>(
        builder: (context, testData, child) => Consumer<VocflDataProvider>(
          builder: (context, prov, child) {
            final gg = prov.wordsSetList.fold((l) => l, (r) => r);
            List<Word> words = [];

            if (gg is Failure)
              FailedScreen(message: gg.message);
            else if (gg is MultipleWordsSet) {
              try {
                words = gg.wordsSetList[setIndex].words;
              } on Exception {
                return FailedScreen(message: "could not find setIndex...");
              }
            } else {
              FailedScreen(message: "Unknown Error");
            }

            List<int> choices = ChoiceGenerator(words, widget.currIndex)
                .create(); // ex [1 ,2, 3,]
            widget.cardText = words[widget.currIndex].spelling;
            widget.ans = words[widget.currIndex].meaning;
            final choiceButtons = [
              TextButton(
                onPressed: () {
                  setState(() {
                    testData.rightAdd(words[widget.currIndex]);
                    widget.currIndex++;
                    if (widget.currIndex == words.length) {
                      widget.currIndex = 0;
                      // move to result page
                      AppRouter.replaceRouteTo(context, ResultView.routeName,
                          ScreenArguments(args: {}));
                    }
                  });
                },
                child: Text(widget.ans),
              ),
              TextButton(
                onPressed: () {
                  testData.wrongAdd(words[widget.currIndex]);
                  final newWord = Word(
                      meaning: words[widget.currIndex].meaning,
                      spelling: words[widget.currIndex].spelling,
                      wCounts: words[widget.currIndex].wCounts + 1,
                      importance: words[widget.currIndex].importance);

                  prov.editWord(setIndex, widget.currIndex, newWord);
                  widget.currIndex++;
                  if (widget.currIndex == words.length) {
                    widget.currIndex = 0;
                    // move to result page

                    AppRouter.replaceRouteTo(context, ResultView.routeName,
                        ScreenArguments(args: {}));
                  }
                  setState(() {
                    widget.cardText = words[widget.currIndex].spelling;
                  });
                },
                child: words.length > choices[0]
                    ? Text(words[choices[0]].meaning)
                    : Text("Blank"),
              ),
              TextButton(
                onPressed: () {
                  testData.wrongAdd(words[widget.currIndex]);
                  final newWord = Word(
                      meaning: words[widget.currIndex].meaning,
                      spelling: words[widget.currIndex].spelling,
                      wCounts: words[widget.currIndex].wCounts + 1,
                      importance: words[widget.currIndex].importance);

                  prov.editWord(setIndex, widget.currIndex, newWord);
                  widget.currIndex++;

                  if (widget.currIndex == words.length) {
                    widget.currIndex = 0;

                    AppRouter.replaceRouteTo(context, ResultView.routeName,
                        ScreenArguments(args: {}));
                  }
                  setState(() {
                    widget.cardText = words[widget.currIndex].spelling;
                  });
                },
                child: words.length > choices[1]
                    ? Text(words[choices[1]].meaning)
                    : Text("Blank"),
              ),
              TextButton(
                onPressed: () {
                  testData.wrongAdd(words[widget.currIndex]);
                  final newWord = Word(
                      meaning: words[widget.currIndex].meaning,
                      spelling: words[widget.currIndex].spelling,
                      wCounts: words[widget.currIndex].wCounts + 1,
                      importance: words[widget.currIndex].importance);

                  prov.editWord(setIndex, widget.currIndex, newWord);
                  widget.currIndex++;
                  if (widget.currIndex == words.length) {
                    widget.currIndex = 0;

                    AppRouter.replaceRouteTo(context, ResultView.routeName,
                        ScreenArguments(args: {}));
                  }
                  setState(() {
                    widget.cardText = words[widget.currIndex].spelling;
                  });
                },
                child: words.length > choices[2]
                    ? Text(words[choices[2]].meaning)
                    : Text("Blank"),
              ),
            ];

            choiceButtons.shuffle();
            return Column(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                        child: Text(
                      widget.cardText,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                Column(
                  // 후보군
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [...choiceButtons],
                )
              ],
            );
          },
        ),
      ),
    ));
  }
}
