import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/analysis_provider.dart';

class AnalysisView extends StatefulWidget {
  static const String routeName = '/analysis';
  const AnalysisView({super.key});

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  String str = 'Not loaded';
  @override
  Widget build(BuildContext context) {
    return Consumer<AnalysisProvider>(builder: (context, analysis, child) {
      return Scaffold(
          appBar: AppBar(),
          body: Row(
            children: [
              Container(child: Text(str)),
              TextButton(
                child: Text("hit"),
                onPressed: () async {
                  await analysis.updateAnalysisData();
                  await analysis.getAnalysisData().then((value) => value.fold(
                      (l) => str = l.message,
                      (r) => str = r.rWords[6].rCounts.toString()));
                  setState(() {});
                },
              ),
            ],
          ));
    });
  }
}
