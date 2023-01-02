import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/single_words_set.dart';
import '../../providers/multiple_words_provider.dart';
import '../../widgets/custom_scroll.dart';
import '../../widgets/router.dart';
import '../AddDirectView/widgets/failed_screen.dart';
import '../FlashCardView/flash_card_screen.dart';
import '../WordEditView/word_edit_view.dart';
import '../WordTestView/word_test_view.dart';

class WordsSetScreen extends StatefulWidget {
  static const String routeName = '/words-set';

  @override
  State<WordsSetScreen> createState() => _WordsSetScreenState();
}

class _WordsSetScreenState extends State<WordsSetScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenArguments query =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    int setIndex = query.args['SetIndex'];

    final _form = GlobalKey<FormState>();

    return Consumer<VocflDataProvider>(builder: (context, prov, child) {
      final wordsSet =
          prov.wordsSetList.fold((l) => l, (r) => r.wordsSetList[setIndex]);
      String title = '';
      if (wordsSet is SingleWordsSet) {
        title = wordsSet.title;
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(title),
                IconButton(
                  iconSize: 15,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text("단어장 이름 입력"),
                              content: Form(
                                key: _form,
                                child: TextFormField(
                                  initialValue: title,
                                  decoration: InputDecoration(),
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {},
                                  onSaved: (val) {
                                    title = val as String;
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      _form.currentState!.save();
                                      prov.addWordsSet(SingleWordsSet(
                                          title: title,
                                          id: wordsSet.id,
                                          words: wordsSet.words,
                                          wordType: wordsSet.wordType));
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"))
                              ],
                            ));
                  },
                ),
              ],
            ),
          ),
          body: viewbuilder(context, prov, wordsSet, setIndex),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).primaryColor,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book), label: "학습하기"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books), label: "시험치기"),
            ],
            onTap: ((value) {
              if (value == 0) {
                AppRouter.pushRouteTo(context, FlashCard.routeName,
                    ScreenArguments(args: {"setIndex": setIndex}));
                return;
              } else if (value == 1) {
                AppRouter.pushRouteTo(context, WordTestView.routeName,
                    ScreenArguments(args: {"setIndex": setIndex}));
                return;
              }

              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     builder: (_) => AlertDialog(
              //           title: Text("Error!"),
              //           content: Text(str + " is not implemented yet"),
              //           actions: [
              //             TextButton(
              //                 onPressed: () => Navigator.of(context).pop(),
              //                 child: Text("OK"))
              //           ],
              //         ));
            }),
          ),
        );
      } else if (wordsSet is Failure) {
        return FailedScreen(message: wordsSet.message);
      } else {
        return const FailedScreen(message: "Something went wrong");
      }
    });
  }
}

Widget viewbuilder(context, prov, SingleWordsSet ws, int setIndex) {
  final words = ws.words;
  return ScrollConfiguration(
    behavior: CustomScroll(),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          height: MediaQuery.of(context).size.height * 0.818,
          child: ListView.builder(
            itemBuilder: (context, index) {
              String reducedMeaning = '';
              if (index < words.length) {
                reducedMeaning = words[index].meaning;
                if (words[index].meaning.length > 9) {
                  reducedMeaning = words[index].meaning.substring(0, 9) + '...';
                }
              }

              String reducedSpelling = '';
              if (index < words.length) {
                reducedSpelling = words[index].spelling;
                if (words[index].spelling.length > 9) {
                  reducedSpelling =
                      words[index].spelling.substring(0, 9) + '...';
                }
              }
              return index == words.length
                  ? Center(
                      //플러스 버튼
                      child: InkWell(
                        onTap: () => AppRouter.pushRouteTo(
                            context,
                            WordsEditView.routeName,
                            ScreenArguments(args: {"setIndex": setIndex})),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: MediaQuery.of(context).size.height * 0.05,
                            right: MediaQuery.of(context).size.height * 0.05,
                          ),
                          height: MediaQuery.of(context).size.height * 0.10,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Icon(size: 40, Icons.add),
                                ),
                              ]),
                        ),
                      ),
                    )
                  : InkWell(
                      // 아이템
                      onTap: () => AppRouter.pushRouteTo(
                          context,
                          WordsEditView.routeName,
                          ScreenArguments(args: {
                            "setIndex": setIndex,
                            "wordIndex": index
                          })),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: MediaQuery.of(context).size.height * 0.05,
                          right: MediaQuery.of(context).size.height * 0.05,
                        ),
                        height: MediaQuery.of(context).size.height * 0.10,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Center(
                                          child: Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ))),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: const VerticalDivider(
                                      indent: 10,
                                      thickness: 2,
                                      endIndent: 10,
                                      color: Color.fromARGB(130, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Center(
                                          child: RatingBar.builder(
                                            allowHalfRating: true,
                                            itemSize: 13,
                                            glow: false,
                                            initialRating:
                                                words[index].importance,
                                            ignoreGestures: true,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.black,
                                            ),
                                            onRatingUpdate: (double value) {},
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Center(
                                            child: Text(
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.red),
                                                words[index]
                                                    .wCounts
                                                    .toString())),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Center(
                                            child: Text(reducedSpelling,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ))),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Center(
                                            child: Text(reducedMeaning,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ))),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    );
            },
            itemCount: words.length + 1,
          ),
        ),
      ],
    ),
  );
}
