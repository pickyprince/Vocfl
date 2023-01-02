import 'package:Vocfl/features/wss_management/domain/entities/analysis_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../../../../main_init/injection_container.dart' as di;
import '../../domain/entities/right_word.dart';
import '../../domain/entities/wrong_word.dart';
import '../../domain/usecases/get_analysis_data.dart' as ga;
import '../../domain/usecases/update_analysis_data.dart' as ua;

class AnalysisProvider extends ChangeNotifier {
  Either<Failure, AnalysisData> data = Left(Loading());
  AnalysisProvider() {
    Future.microtask(() => fetchData());
  }

  Future<void> fetchData() async {
    print("fetching 분석 데이터 시작");
    final result = await di.sl<ga.GetAnalysisData>()(ga.NoParams());
    final temp = result.fold((l) => l, (r) => r);
    if (temp is Failure) {
      print("분석 데이터를 가져오는데 실패 했습니다.$temp");
      (await di.sl<ua.UpdateAnalysisData>()(
              ua.Params(data: AnalysisData(rWords: [], wWords: []))))
          .fold(
        (l) {
          print(l.message);
        },
        (r) {
          print("비어있는 분석 데이터를 생성합니다...");
        },
      );
      data = await di.sl<ga.GetAnalysisData>()(ga.NoParams());
      if (data is Failure) {
        print("fetching 실패... $data");
      }
    } else if (temp is AnalysisData) {
      print("분석 데이터 존재 fetching 시작");
      data = Right(temp);
    }
    notifyListeners();
    print("fetching 분석 데이터 종료");
  }

  Future<Either<Failure, AnalysisData>> getAnalysisData() async {
    return data;
  }

  Future<void> updateAnalysisData() async {
    final obj = data.fold((l) => l, (r) => r);
    if (obj is AnalysisData) {
      await di.sl<ua.UpdateAnalysisData>()(ua.Params(data: obj));
      print("분석 데이터를 업데이트합니다..");
      fetchData();
      notifyListeners();
    }
  }

  void addRightWord(RightWord word) {
    final data = this.data.fold((l) => l, (r) => r);
    if (data is AnalysisData) {
      if (!data.rWords.contains(word)) {
        data.rWords.add(word);
        print("분석 데이터에 맞은 단어가 성공적으로 추가되었습니다.");
      } else {
        final index = data.rWords.indexWhere((element) => element == word);
        data.rWords[index] = RightWord(
          originalSpelling: data.rWords[index].originalSpelling,
          rCounts: data.rWords[index].rCounts + 1,
          time: data.rWords[index].time,
        );
        print("분석 데이터에 이미 맞은 단어가 있으므로 맞은 횟수만 증가시킵니다.");
      }
    } else {
      print("데이터가 비었습니다.");
    }
  }

  void addWrongWord(WrongWord word) {
    final data = this.data.fold((l) => l, (r) => r);
    if (data is AnalysisData) {
      if (!data.wWords.contains(word)) {
        data.wWords.add(word);
      } else {
        final index = data.wWords.indexWhere((element) => element == word);
        data.wWords[index] = WrongWord(
          originalSpelling: data.wWords[index].originalSpelling,
          wCounts: data.wWords[index].wCounts + 1,
          time: data.wWords[index].time,
        );
      }
    }
  }

  void deleteWrongWord(WrongWord word) {
    final data = this.data.fold((l) => l, (r) => r);
    if (data is AnalysisData) {
      if (!data.wWords.contains(word)) {
        data.wWords.removeWhere(
          (element) => element == word,
        );
      }
    }
  }

  void deleteRightWord(RightWord word) {
    final data = this.data.fold((l) => l, (r) => r);
    if (data is AnalysisData) {
      if (!data.rWords.contains(word)) {
        data.rWords.removeWhere(
          (element) => element == word,
        );
      }
    }
  }
}
