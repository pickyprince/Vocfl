import '../core/error/failures.dart';
import './injection_container.dart' as di;

import 'package:Vocfl/main_init/init_example.dart';
import 'package:Vocfl/features/wss_management/domain/entities/ini.dart';
import 'package:Vocfl/features/wss_management/domain/usecases/get_ini.dart'
    as gi;
import 'package:Vocfl/features/wss_management/domain/usecases/update_ini.dart'
    as ui;

Future<void> vocflInit() async {
  // ini 파일이 만들어졌는지 확인 후에 만약 처음이라 없다면 플래그를 마크하고 있다면 플래그 마크 후 할당
  bool isCreated = false;
  final temp = await di.sl<gi.GetIni>()(gi.NoParams());
  final obj = temp.fold((l) => l, (r) => r);
  if (obj is Failure) {
    isCreated = false;
    print("ini.json파일이 존재하지 않습니다.");
    print(obj.message);
  } else {
    isCreated = true;
    print("ini.json파일이 이미 존재합니다.");
  }

  if (!isCreated) {
    final temp1 = await di.sl<ui.UpdateIni>()(ui.Params(
        ini: Ini(
      isFetchedBasicWordsSets: false,
      isFirstTime: true,
    )));
    temp1.fold((l) {
      print("ini.json파일 생성 과정에서 오류가 발생했습니다.");
      print(l.message);
    }, (r) {
      isCreated = true;
      print("ini.json파일이 생성되었습니다.");
    });
  }

  // 이 명령이 실행되기 전에 무조건 ini 파일 생성완료
  await di.sl<gi.GetIni>()(gi.NoParams()).then((value) {
    value.fold((l) => print(l.message), (ini) async {
      if (!ini.isFetchedBasicWordsSets) {
        createExample();
        print("예시 단어장 생성완료");
        await di.sl<ui.UpdateIni>()(ui.Params(
            ini: Ini(
          isFetchedBasicWordsSets: true,
          isFirstTime: ini.isFirstTime,
        )));
        print("ini_loader 실행 완료");
        return;
      }
    });
  });
}
