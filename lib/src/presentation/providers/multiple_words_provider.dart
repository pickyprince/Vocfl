import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import '../../domain/entities/single_words_set.dart';
import '../../domain/usecases/add_words_set_to_repository.dart' as aw;
import '../../domain/usecases/delete_words_set.dart' as dw;
import '../../domain/usecases/get_every_words_sets.dart' as gew;
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/multiple_words_set.dart';
import '../../../../main_init/injection_container.dart' as di;

import '../../domain/entities/word.dart';
import '../../domain/usecases/update_word.dart' as uw;
import '../../domain/usecases/delete_word.dart' as dww;
import '../../domain/usecases/add_word.dart' as aww;

class VocflDataProvider extends ChangeNotifier {
  Either<Failure, MultipleWordsSet> wordsSetList = Left(Loading());
  VocflDataProvider() {
    Future.microtask(() => fetchData());
  }
  Future<void> fetchData() async {
    wordsSetList = await di.sl<gew.GetEveryWordsSets>()(gew.NoParams());
    notifyListeners();
  }

  Future<void> addWordsSet(SingleWordsSet single) async {
    await di.sl<aw.AddSingleWordsSetToRepository>()(
        aw.Params(singleWordsSet: single));

    await fetchData();
    notifyListeners();
  }

  Future<void> deleteWordsSet(String id) async {
    await di.sl<dw.DeleteWordsSet>()(dw.Params(deleteId: id));
    await fetchData();
    notifyListeners();
  }

  Future<void> addWord(int setIndex, Word word) async {
    final check = wordsSetList.fold((l) => l, (r) => r);
    if (check is Failure) {
      return;
    } else if (check is MultipleWordsSet) {
      await di.sl<aww.AddWordToRepository>()(
          aww.Params(word: word, wordsSet: check.wordsSetList[setIndex]));

      await fetchData();
      notifyListeners();
    }
  }

  Future<void> editWord(int setIndex, int wordIndex, Word word) async {
    final check = wordsSetList.fold((l) => l, (r) => r);
    if (check is Failure) {
      return;
    } else if (check is MultipleWordsSet) {
      await di.sl<uw.UpdateWordToRepository>()(uw.Params(
        word: word,
        wordIndex: wordIndex,
        wordsSet: check.wordsSetList[setIndex],
      ));

      await fetchData();
      notifyListeners();
    }
  }

  Future<void> deleteWord(int setIndex, int wordIndex) async {
    final check = wordsSetList.fold((l) => l, (r) => r);
    if (check is Failure) {
      return;
    } else if (check is MultipleWordsSet) {
      await di.sl<dww.DeleteWordFromRepository>()(dww.Params(
        wordIndex: wordIndex,
        wordsSet: check.wordsSetList[setIndex],
      ));

      await fetchData();
      notifyListeners();
    }
  }

  Future<String> csvFileImport() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );
    if (result != null) {
      final csvFile = new File(result.files.single.path as String).openRead();
      final finalResult = await csvFile
          .transform(utf8.decoder)
          .transform(
            CsvToListConverter(),
          )
          .toList();
      List<Word> words = [];
      for (int i = 0; i < finalResult.length; i++) {
        words
            .add(Word(spelling: finalResult[i][0], meaning: finalResult[i][1]));
      }
      await addWordsSet(SingleWordsSet(
          id: DateTime.now().toString(),
          title: DateTime.now().toString().substring(0, 10),
          words: words,
          wordType: "UN"));
      return finalResult.toString();
      //meta check

      //convert csv file to singlewordset entity

      //save converted entity to the repository
    }
    return '';
  }
}
