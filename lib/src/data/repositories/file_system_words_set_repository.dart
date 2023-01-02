import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../data/datasources/local_data_source.dart';
import '../../data/models/multiple_words_set_model.dart';
import '../../data/models/single_words_set_model.dart';
import '../../data/models/word_model.dart';
import '../../domain/entities/single_words_set.dart';
import '../../domain/entities/multiple_words_set.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/word.dart';
import '../../domain/repositories/words_set_repositories.dart';

class FilesystemWordsSetRepository implements WordsSetRepository {
  final LocalDataSource localDataSource;

  FilesystemWordsSetRepository({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> addMultipleWordsSetsToRepository(
      MultipleWordsSet items) async {
    try {
      Map<String, dynamic> wordsSetMap =
          MultipleWordsSetModel(wordsSetList: items.wordsSetList).toJson();
      final result = await localDataSource
          .writeMultipleWordsSetsToLocalDataSource(wordsSetMap);
      return Right(result);
    } on LocalDataSourceException {
      return Left(DataSourceFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addWordsSetToRepository(
      SingleWordsSet item) async {
    try {
      Map<String, dynamic> wordsSetMap = SingleWordsSetModel(
              id: item.id,
              title: item.title,
              words: item.words,
              wordType: item.wordType)
          .toJson();
      final result = await localDataSource
          .writeSingleWordsSetsToLocalDataSource(wordsSetMap);
      return Right(result);
    } on LocalDataSourceException {
      return Left(DataSourceFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteWordsSet(String wordSetsId) async {
    try {
      final result = await localDataSource
          .deleteWordsSetByIdFromLocalDataSource(wordSetsId);
      return Right(result);
    } on LocalDataSourceException {
      return Left(DataSourceFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, MultipleWordsSet>> getEveryWordsSets() async {
    try {
      final modelData = MultipleWordsSetModel.fromJson(
          await localDataSource.readAllFilesFromLocalDataSource());
      MultipleWordsSet result =
          MultipleWordsSet(wordsSetList: modelData.wordsSetList);
      return Right(result);
    } on LocalDataSourceEmptyException {
      return Left(LocalDataSourceEmptyFailure());
    } on LocalDataSourceException {
      return Left(DataSourceFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, SingleWordsSet>> getOneWordsSet(
      String wordSetsId) async {
    try {
      final modelData = SingleWordsSetModel.fromJson(await localDataSource
          .readSingleFileByIdFromLocalDataSource(wordSetsId));
      SingleWordsSet result = SingleWordsSet(
          title: modelData.title,
          id: modelData.id,
          words: modelData.words,
          wordType: modelData.wordType);
      return Right(result);
    } on LocalDataSourceException {
      return Left(DataSourceFailure());
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateWordsSet(SingleWordsSet item) async {
    try {
      final modelData = SingleWordsSetModel(
              title: item.title,
              id: item.id,
              words: item.words,
              wordType: item.wordType)
          .toJson();
      void result = await localDataSource.updateWordsSetById(modelData);
      return Right(result);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addWord(SingleWordsSet item, Word word) async {
    try {
      item.words.add(WordModel(
        spelling: word.spelling,
        meaning: word.meaning,
        importance: word.importance,
        wCounts: word.wCounts,
      ));
      final modelData = SingleWordsSetModel(
              title: item.title,
              id: item.id,
              words: item.words,
              wordType: item.wordType)
          .toJson();
      void result = await localDataSource.updateWordsSetById(modelData);
      return Right(result);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteWord(
      SingleWordsSet wordSet, int wordIndex) async {
    try {
      wordSet.words.removeAt(wordIndex);
      final modelData = SingleWordsSetModel(
              title: wordSet.title,
              id: wordSet.id,
              words: wordSet.words,
              wordType: wordSet.wordType)
          .toJson();
      void result = await localDataSource.updateWordsSetById(modelData);
      return Right(result);
    } on Exception {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateWord(
      SingleWordsSet wordSet, int wordIndex, Word word) async {
    try {
      wordSet.words[wordIndex] = WordModel(
        spelling: word.spelling,
        meaning: word.meaning,
        importance: word.importance,
        wCounts: word.wCounts,
      );
      final modelData = SingleWordsSetModel(
              title: wordSet.title,
              id: wordSet.id,
              words: wordSet.words,
              wordType: wordSet.wordType)
          .toJson();
      void result = await localDataSource.updateWordsSetById(modelData);
      return Right(result);
    } on Exception {
      return Left(UnknownFailure());
    }
  }
}
