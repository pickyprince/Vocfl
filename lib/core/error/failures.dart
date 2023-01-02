import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final message = "";
  @override
  List<Object?> get props {
    return [message];
  }
}

class DataSourceFailure extends Failure {
  final message = 'DataSourceFailure';
  @override
  List<Object?> get props {
    return [message];
  }
}

class UnknownFailure extends Failure {
  final message = 'UnknownFailure';
  @override
  List<Object?> get props {
    return [message];
  }
}

class LoadingFailure extends Failure {
  final message = 'LoadingFailure';
  @override
  List<Object?> get props {
    return [message];
  }
}

class DirectorySetupFailure extends Failure {
  final message = 'DirectorySetupFailure';
  @override
  List<Object?> get props {
    return [message];
  }
}

class FileReadFailure extends Failure {
  final message = 'FileReadFailure';
  @override
  List<Object?> get props {
    return [message];
  }
}

class FileWriteFailure extends Failure {
  final message = 'FileWriteFailure';
  @override
  List<Object?> get props {
    return [message];
  }
}

class Loading extends Failure {
  final message = '데이터 로딩중입니다...';
  @override
  List<Object?> get props {
    return [message];
  }
}

class LocalDataSourceEmptyFailure extends Failure {
  final message = '로컬 디렉토리가 비었습니다.\n 새로운 단어장을 만드세요!';
  @override
  List<Object?> get props {
    return [message];
  }
}
