import 'dart:io';

import 'package:dartz/dartz.dart' as dartz;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/error/failures.dart';
import '../../providers/multiple_words_provider.dart';

class ImportView extends StatefulWidget {
  static const String routeName = '/import';

  @override
  State<ImportView> createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> {
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<VocflDataProvider>(
        builder: (context, prov, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //이미지 추가 해야함
              Text(text),
              Center(
                child: Container(
                  child: TextButton(
                    child: Text("CSV 파일 추출하기"),
                    onPressed: () async {
                      text = await prov.csvFileImport();
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
