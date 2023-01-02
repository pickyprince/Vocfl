import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/multiple_words_set.dart';
import '../../../domain/entities/word.dart';
import '../../providers/multiple_words_provider.dart';
import '../../widgets/router.dart';
import '../AddDirectView/widgets/failed_screen.dart';

class FlashCard extends StatefulWidget {
  static const routeName = '/flash-card';
  var card_text_front = '';
  var card_text_back = '';
  var card_text = '시작하려면 탭하세요!';
  var curr_index = 0;
  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final setIndex = args.args['setIndex'];

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("플래시카드 학습하기")),
      body: Consumer<VocflDataProvider>(
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
          //words <- 데이터 로드 완료

          widget.card_text_front = words[widget.curr_index].spelling;
          widget.card_text_back = words[widget.curr_index].meaning;
          return Column(
            children: [
              Center(
                child: InkWell(
                  radius: 10,
                  splashColor: Colors.grey,
                  highlightColor: Colors.grey,
                  onTap: () {
                    widget.card_text == widget.card_text_front
                        ? widget.card_text = widget.card_text_back
                        : widget.card_text = widget.card_text_front;
                    setState(() {});
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                        child: Text(
                      widget.card_text,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.curr_index--;
                      if (widget.curr_index < 0) {
                        widget.curr_index = 0;
                      }
                      setState(() {
                        widget.card_text = words[widget.curr_index].spelling;
                      });
                    },
                    child: Text("이전"),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.curr_index++;
                      if (widget.curr_index == words.length) {
                        widget.curr_index = 0;
                      }
                      setState(() {
                        widget.card_text = words[widget.curr_index].spelling;
                      });
                    },
                    child: Text("다음"),
                  )
                ],
              )
            ],
          );
        },
      ),
    ));
  }
}
