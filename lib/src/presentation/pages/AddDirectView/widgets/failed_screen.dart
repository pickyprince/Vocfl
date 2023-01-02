import 'package:flutter/material.dart';

class FailedScreen extends StatelessWidget {
  final String message;
  const FailedScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("스크린을 생성 중 에러가 발생했습니다.\n ERROR: $message"),
        ),
      ],
    );
  }
}
