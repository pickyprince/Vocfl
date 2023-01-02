import 'package:flutter/material.dart';
import '../../../../../wss_management/presentation/pages/AddDirectView/ws_direct_screen.dart';
import '../../../../../wss_management/presentation/pages/AddImportView/ws_import_screen.dart';
import '../../../../../wss_management/presentation/pages/SettingView/setting_screen.dart';

class DrawerData {
  static const List<Map<String, String>> DrawerLists = [
    {'title': '설정', 'route': SettingScreen.routeName},
    {'title': '새로운 단어장', 'route': AddWordsSet.routeName},
    {'title': 'CSV 파일 추출', 'route': ImportView.routeName},
    {'title': '학습 분석', 'route': SettingScreen.routeName},
  ];
}

class HomeDrawer extends StatelessWidget {
  void moveToScreen(BuildContext context, routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 200,
        backgroundColor: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 10,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return Container(
                      width: double.infinity,
                      child: TextButton(
                        child: Text(
                          DrawerData.DrawerLists[index]["title"].toString(),
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () => moveToScreen(
                          context,
                          DrawerData.DrawerLists[index]['route'],
                        ),
                      ),
                    );
                  }),
                  itemCount: DrawerData.DrawerLists.length,
                ),
              ),
            ],
          ),
        ));
  }
}
