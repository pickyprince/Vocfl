import 'package:flutter/material.dart';
import 'package:Vocfl/features/wss_management/presentation/pages/WordEditView/widgets/body.dart';

class WordsEditView extends StatelessWidget {
  static const routeName = '/words-edit';
  const WordsEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("단어 추가")),
      body: const WordsEditViewBody(),
    );
  }
}
