import 'package:Vocfl/features/ws_management/presentation/pages/ws_manager_page/widgets/home_filter_modal.dart';
import 'package:Vocfl/features/ws_management/presentation/pages/ws_manager_page/widgets/listview_plus_button.dart';
import 'package:Vocfl/features/ws_management/presentation/pages/ws_manager_page/widgets/listview_words_set_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../wss_management/domain/entities/multiple_words_set.dart';
import '../../../../../wss_management/presentation/providers/filter_option_provider.dart';
import '../../../../../wss_management/presentation/providers/multiple_words_provider.dart';
import '../../../../../wss_management/presentation/widgets/custom_scroll.dart';

class WordsSetListViewLayout extends StatelessWidget {
  final MultipleWordsSet list;
  final VocflDataProvider prov;
  const WordsSetListViewLayout(
      {super.key, required this.list, required this.prov});

  @override
  Widget build(BuildContext context) {
    final data = list.wordsSetList;
    return Consumer<HomeFilterProvider>(builder: (context, filter, child) {
      HomeFilterOptions? filterOption = filter.currentFilterOpt;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) => const HomeFilterModal(),
                      );
                    },
                    icon: const Icon(Icons.filter_list_alt)),
              )
            ]),
          ),
          ScrollConfiguration(
            behavior: CustomScroll(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.765,
              child: ListView.builder(
                itemBuilder: ((context, index) => index == data.length
                    ? const HomeWordsSetPlusButton()
                    : WordsSetListItem(
                        prov: prov,
                        data: data,
                        index: index,
                        filterOpt: filterOption,
                      )),
                itemCount: data.length + 1,
              ),
            ),
          ),
        ],
      );
    });
  }
}
