import 'package:flutter/material.dart';

class Settings with ChangeNotifier {
  List<Map<String, bool>> _settingsList = [
    {
      '텍스트 크기 키우기': false,
      'textAvailable': true,
      'powerAvailable': true,
    }
  ];

  List<Map<String, bool>> get settingsList {
    return [..._settingsList];
  }

  void toggleSettings(String name, bool value) {
    _settingsList[0][name] = value;

    notifyListeners();
  }
}
