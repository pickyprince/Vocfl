import 'package:Vocfl/features/wss_management/domain/entities/analysis_data.dart';
import 'package:Vocfl/features/wss_management/domain/entities/right_word.dart';
import 'package:Vocfl/features/wss_management/presentation/providers/analysis_provider.dart';
import 'package:Vocfl/features/wss_management/presentation/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:Vocfl/features/wss_management/presentation/providers/test_result_provider.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/word.dart';
import '../../../domain/entities/wrong_word.dart';
import '../../providers/settings-provider.dart';
import 'package:provider/provider.dart';

class ResultView extends StatefulWidget {
  static const String routeName = '/test-result';

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnalysisProvider>(builder: (context, analysis, child) {
      return Consumer<TestResultProvider>(builder: (context, testData, child) {
        final len = testData.wCounts + testData.rCounts;
        final per = (100 * testData.rCounts / len).round();
        final testResultText = '와 대단해요!!';

        return Scaffold(
          appBar: AppBar(
            title: Text("시험 결과"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () async {
                MaterialPageRoute(builder: (context) => const LoadingView());
                while (analysis
                        .getAnalysisData()
                        .then((value) => value.fold((l) => l, (r) => r))
                    is Loading) {}
                Navigator.of(context).pop();

                for (Word item in testData.rights) {
                  analysis.addRightWord(RightWord(
                      originalSpelling: item.spelling,
                      rCounts: 1,
                      time: DateTime.now().toString()));
                  print("addrightWord");
                }

                for (Word item in testData.wrongs) {
                  analysis.addWrongWord(WrongWord(
                      originalSpelling: item.spelling,
                      wCounts: 1,
                      time: DateTime.now().toString()));
                  print("addwrongWord");
                }
                print("분석데이터 생성 완료..");

                testData.reset();
                analysis.updateAnalysisData();
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(''),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        testResultText,
                        style: TextStyle(fontSize: 30),
                      ),
                    )),
                Text("$per%", style: TextStyle(fontSize: 25)),
                Text(
                    "(" +
                        testData.rCounts.toString() +
                        "/" +
                        len.toString() +
                        ")",
                    style: TextStyle(fontSize: 18)),
                Text("\n맞은 단어: " + testData.rCounts.toString() + "개",
                    style: TextStyle(fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints.tightFor(height: 60),
                      child: Text(
                          "\n틀린 단어: " + testData.wCounts.toString() + "개",
                          style: TextStyle(fontSize: 18)),
                    ),
                    IconButton(
                        iconSize: 20,
                        constraints: BoxConstraints.tightFor(height: 40),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios))
                  ],
                )
              ],
            ),
          ),
        );
      });
    });
  }
}
