import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../domain/entities/multiple_words_set.dart';
import '../../../../domain/entities/word.dart';
import '../../../providers/multiple_words_provider.dart';
import '../../../widgets/router.dart';
import '../../AddDirectView/widgets/failed_screen.dart';

class WordsEditViewBody extends StatefulWidget {
  const WordsEditViewBody({super.key});

  @override
  State<WordsEditViewBody> createState() => _WordsEditViewBodyState();
}

class _WordsEditViewBodyState extends State<WordsEditViewBody> {
  final _meaningFocusNode = FocusNode();
  final _wordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  ScrollController controller = ScrollController();
  String meaning = '';
  String spelling = '';
  double importance = 3;
  int wCounts = 0;

  @override
  dispose() {
    super.dispose();
    _meaningFocusNode.dispose();
    _wordFocusNode.dispose();
    controller.dispose();
  }

  void _saveForm(VocflDataProvider prov, setIndex, wordIndex, bool isNew) {
    _form.currentState!.save();

    final word = Word(
        meaning: meaning,
        spelling: spelling,
        importance: importance,
        wCounts: wCounts);

    isNew
        ? prov.addWord(setIndex, word)
        : prov.editWord(setIndex, wordIndex, word);
    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenArguments sArg =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    bool isNewWord = false;
    int wordIndex = 0;
    if (sArg.args["wordIndex"] == null) {
      isNewWord = true;
    } else {
      wordIndex = sArg.args["wordIndex"];
    }
    final setIndex = sArg.args["setIndex"];

    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.817,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Consumer<VocflDataProvider>(builder: (context, prov, child) {
          final data = prov.wordsSetList.fold((l) => l, (r) => r);
          if (data is Failure) {
            return FailedScreen(message: data.message);
          } else if (data is MultipleWordsSet) {
            if (!isNewWord) {
              Word temp = data.wordsSetList[setIndex].words[wordIndex];
              importance = temp.importance;
              spelling = temp.spelling;
              meaning = temp.meaning;
              wCounts = temp.wCounts;
            }
          } else {
            return const FailedScreen(message: "Something went wrong!");
          }
          return Column(children: [
            Form(
              key: _form,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      initialValue: isNewWord ? null : spelling,
                      decoration: InputDecoration(
                        labelText: "스펠링",
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_wordFocusNode);
                      },
                      onSaved: (val) {
                        spelling = val as String;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      initialValue: isNewWord ? null : meaning,
                      decoration: InputDecoration(
                        labelText: "의미",
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_wordFocusNode);
                      },
                      onSaved: (val) {
                        meaning = val as String;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                            child: Center(
                                child: Text(
                          "난이도",
                          style: TextStyle(fontSize: 17),
                        ))),
                        RatingBar.builder(
                          itemSize: 25,
                          glow: false,
                          initialRating: isNewWord ? 3 : importance,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.black,
                          ),
                          onRatingUpdate: (rating) {
                            importance = rating;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                            child: Center(
                                child: Text(
                          "틀린 횟수",
                          style: TextStyle(fontSize: 17),
                        ))),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Center(
                                child: Text(
                              wCounts.toString(),
                              style: TextStyle(
                                  fontSize: 17, color: Colors.redAccent),
                            ))),
                        IconButton(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          color: Colors.black87,
                          iconSize: 25,
                          onPressed: () {
                            final t =
                                data.wordsSetList[setIndex].words[wordIndex];
                            prov.editWord(
                                setIndex,
                                wordIndex,
                                Word(
                                    spelling: t.spelling,
                                    meaning: t.meaning,
                                    importance: t.importance));
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () =>
                              _saveForm(prov, setIndex, wordIndex, isNewWord),
                          child: Text("완료")),
                    ],
                  ),
                  isNewWord
                      ? Row()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  await prov.deleteWord(setIndex, wordIndex);
                                  Navigator.of(context).pop();
                                },
                                child: Text("단어 삭제",
                                    style: TextStyle(color: Colors.redAccent))),
                          ],
                        ),
                ],
              ),
            )
          ]);
        }),
      ),
    );
  }
}
