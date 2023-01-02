import 'package:flutter/material.dart';
import '../../providers/settings-provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    final settingsData = Provider.of<Settings>(context);
    final keys = settingsData.settingsList[0].keys.toList();
    return Scaffold(
        appBar: AppBar(title: Text("세팅 페이지")),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                final bool val =
                    settingsData.settingsList[0][keys[index]] as bool;
                if (val == null) {
                  return Row(
                    children: [Center(child: Text("리스트 생성 오류"))],
                  );
                }
                return Row(children: [
                  Text(keys[index]),
                  Switch(
                    value: val,
                    onChanged: (value) {
                      settingsData.toggleSettings(keys[index], value);
                    },
                  )
                ]);
              },
              itemCount: keys.length,
            ),
          ),
        ));
  }
}
