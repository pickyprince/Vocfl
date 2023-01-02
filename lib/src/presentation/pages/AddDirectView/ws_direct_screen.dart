import 'package:flutter/material.dart';
import '../../../domain/entities/multiple_words_set.dart';
import '../../../domain/entities/single_words_set.dart';
import '../../../domain/entities/word.dart';
import '../../providers/multiple_words_provider.dart';
import '../AddDirectView/widgets/failed_screen.dart';
import '../../../presentation/widgets/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart' as dartz;

class AddWordsSet extends StatefulWidget {
  static const String routeName = '/add-select/add-words-set';
  @override
  State<AddWordsSet> createState() => _AddWordsSetState();
}

class _AddWordsSetState extends State<AddWordsSet> {
  final _meaningFocusNode = FocusNode();
  final _wordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  final _titleform = GlobalKey<FormState>();
  ScrollController controller = new ScrollController();

  String title = '';

  List<Word> words = [];
  String spelling = '';
  String meaning = '';
  var result;
  @override
  dispose() {
    super.dispose();
    _meaningFocusNode.dispose();
    _wordFocusNode.dispose();
    controller.dispose();
  }

  void _saveForm(VocflDataProvider prov) {
    _form.currentState!.save();
    _titleform.currentState!.save();
    words.add(Word(meaning: meaning, spelling: spelling));
    result = SingleWordsSet(
        id: DateTime.now().toString(),
        title: title,
        words: words,
        wordType: "EN");
    _form.currentState!.reset();
    setState(() {});
  }

  Widget bodyBuilder(BuildContext context, prov) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.hasClients
          ? controller.animateTo(controller.position.maxScrollExtent,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn)
          : null;
    });

    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _form,
        child: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 0,
                ),
                child: Text(
                  "프리뷰",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )),

            // 프리뷰 컨테이너
            Container(
              margin: EdgeInsets.all(10),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 218, 218, 218),
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        height: 30,
                        width: 20,
                        child: Center(child: Text((index + 1).toString())),
                      ),
                      Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(5),
                        child: Center(child: Text(words[index].spelling)),
                      ),
                      Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(5),
                        child: Center(child: Text(words[index].meaning)),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 24,
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 24,
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            words.removeAt(index);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  );
                },
                controller: controller,
                itemCount: words.length,
              ),
            ),

            // 단어 추가 폼
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                initialValue: '',
                decoration: InputDecoration(labelText: '단어'),
                textInputAction: TextInputAction.next,
                focusNode: _wordFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_meaningFocusNode);
                },
                onSaved: (val) {
                  spelling = val as String;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(labelText: '뜻'),
                  textInputAction: TextInputAction.done,
                  focusNode: _meaningFocusNode,
                  onFieldSubmitted: (_) {
                    _saveForm(prov);
                  },
                  onSaved: (val) {
                    meaning = val as String;
                  }),
            ),
            TextButton(
              child: Text('단어 추가'),
              onPressed: () {
                _saveForm(prov);
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                prov.addWordsSet(result);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<VocflDataProvider>(builder: (context, prov, child) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            margin: EdgeInsets.all(10),
            child: Form(
              key: _titleform,
              child: TextFormField(
                  textInputAction: TextInputAction.next,
                  enableSuggestions: false,
                  autocorrect: false,
                  cursorColor: Colors.white,
                  initialValue: '',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.5),
                    hintText: "새로운 단어장",
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_wordFocusNode);
                  },
                  onSaved: (val) {
                    title = val as String;
                  }),
            ),
          ),
        ),
        body: bodyBuilder(context, prov),
      );
    }));
  }
}
