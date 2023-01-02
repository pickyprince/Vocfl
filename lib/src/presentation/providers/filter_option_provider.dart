import 'package:flutter/material.dart';

enum HomeFilterOptions { date, title, counts }

class HomeFilterProvider with ChangeNotifier {
  HomeFilterOptions? _currentFilterOpt = HomeFilterOptions.date;

  void changeFilterOption(HomeFilterOptions? opt) {
    _currentFilterOpt = opt;
    notifyListeners();
  }

  HomeFilterOptions? get currentFilterOpt {
    return _currentFilterOpt;
  }
}
