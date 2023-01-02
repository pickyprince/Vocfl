import 'package:Vocfl/features/wss_management/domain/entities/ini.dart';

class IniModel extends Ini {
  IniModel(
      {required super.isFetchedBasicWordsSets, required super.isFirstTime});

  //from json
  factory IniModel.fromJson(Map<String, dynamic> json) {
    return IniModel(
      isFetchedBasicWordsSets: json['isFetchedBasicWordsSets'],
      isFirstTime: json['isFirstTime'],
    );
  }
  //to json
  Map<String, dynamic> toJson() {
    return {
      "isFetchedBasicWordsSets": isFetchedBasicWordsSets,
      "isFirstTime": isFirstTime,
    };
  }
}
