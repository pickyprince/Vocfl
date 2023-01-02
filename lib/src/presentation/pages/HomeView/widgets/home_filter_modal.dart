import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../wss_management/presentation/providers/filter_option_provider.dart';

class HomeFilterModal extends StatefulWidget {
  const HomeFilterModal({super.key});

  @override
  State<HomeFilterModal> createState() => _HomeFilterModal();
}

class _HomeFilterModal extends State<HomeFilterModal> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeFilterProvider>(builder: (context, prov, child) {
      return AlertDialog(
        title: const Text("정렬"),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.23,
          child: Column(
            children: [
              RadioListTile<HomeFilterOptions>(
                title: const Text("날짜 순"),
                value: HomeFilterOptions.date,
                groupValue: prov.currentFilterOpt,
                onChanged: (HomeFilterOptions? value) {
                  setState(() {
                    prov.changeFilterOption(value);
                  });
                },
              ),
              RadioListTile<HomeFilterOptions>(
                title: const Text("단어장 이름 순"),
                value: HomeFilterOptions.title,
                groupValue: prov.currentFilterOpt,
                onChanged: (HomeFilterOptions? value) {
                  setState(() {
                    prov.changeFilterOption(value);
                  });
                },
              ),
              RadioListTile<HomeFilterOptions>(
                title: const Text("단어 갯수 순"),
                value: HomeFilterOptions.counts,
                groupValue: prov.currentFilterOpt,
                onChanged: (HomeFilterOptions? value) {
                  setState(() {
                    prov.changeFilterOption(value);
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("닫기")),
        ],
      );
    });
  }
}
