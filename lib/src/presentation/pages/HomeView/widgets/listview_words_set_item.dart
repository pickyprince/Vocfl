import 'package:Vocfl/features/wss_management/domain/entities/single_words_set.dart';
import 'package:flutter/material.dart';

import '../../../../../wss_management/presentation/providers/filter_option_provider.dart';
import '../../../../../wss_management/presentation/providers/multiple_words_provider.dart';
import '../../../../../wss_management/presentation/widgets/router.dart';
import '../../../../../wss_management/presentation/pages/WordsSetView/words_set_screen.dart';

class WordsSetListItem extends StatelessWidget {
  final int index;
  final List<SingleWordsSet> data;
  final HomeFilterOptions? filterOpt;
  final VocflDataProvider prov;
  const WordsSetListItem({
    required this.prov,
    required this.data,
    required this.index,
    super.key,
    required this.filterOpt,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
      height: MediaQuery.of(context).size.height * 0.15,
      child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () => AppRouter.pushRouteTo(
              context,
              WordsSetScreen.routeName,
              ScreenArguments(args: {"SetIndex": index}),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 4, right: 4),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text(data[index].title),
                                        content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.13,
                                          child: Column(
                                            children: [
                                              TextButton(
                                                onPressed: (() {
                                                  prov.deleteWordsSet(
                                                      data[index].id);
                                                  Navigator.of(context).pop();
                                                }),
                                                child: const Text("단어장 삭제"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text("취소"))
                                        ],
                                      ));
                            },
                          ),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 25,
                          child: Container(
                              margin: const EdgeInsets.only(
                                  right: 5, bottom: 1, left: 5),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 238, 238, 238),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          184, 112, 112, 112)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Center(
                                  child: Text(data[index].wordType,
                                      style: const TextStyle(fontSize: 12)))),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(data[index].title)),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: Text("${data[index].words.length} 단어"),
                    ),
                  ],
                ),
                Row(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      data[index].date.toString().substring(0, 10),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                ]),
              ],
            ),
          )),
    );
  }
}
