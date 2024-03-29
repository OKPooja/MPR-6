import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:project/screens/compiler/syntax_highlight.dart';

import '../../api.dart';
import '../../utils/colors.dart';

class CodeInputScreen extends StatefulWidget {
  const CodeInputScreen({Key? key}) : super(key: key);

  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  CodeController? _codeController;
  //Map<String, TextStyle>? theme = monokaiSublimeTheme;
  String _selectedLanguage = 'C++';

  void _showOutputBottomSheet(String output) {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Output',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                output,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    const source = ' ';
    _codeController = CodeController(
      text: source,
      language: cpp,
      patternMap: {
        r'".*"': const TextStyle(color: Colors.white),
        r'[a-zA-Z0-9]+\(.*\)': const TextStyle(color: Colors.white),
        r'^\s*//.*$': const TextStyle(color: Colors.grey), // Single-line comment
        r'/\*[\s\S]*?\*/': const TextStyle(color: Colors.grey), // Multi-line comment
      },
      stringMap: theme,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: AppColors.primary,
        title: Text(
          "Code",
          style: TextStyle(
            fontFamily: 'PragatiNarrow',
            fontSize: 30.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
            GestureDetector(
              onTap: (){

              },
              child: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: (String value) {
              setState(() {
                _selectedLanguage = value;
                if (value == 'C++') {
                  _codeController?.language = cpp;
                  _selectedLanguage = "C++";
                } else if (value == 'Java') {
                  _codeController?.language = java;
                  _selectedLanguage = "Java";
                } else if (value == 'Python') {
                  _codeController?.language = python;
                  _selectedLanguage = "Python";
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'C++',
                child: Text('C++'),
              ),
              const PopupMenuItem<String>(
                value: 'Java',
                child: Text('Java'),
              ),
              const PopupMenuItem<String>(
                value: 'Python',
                child: Text('Python'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: CodeField(
          controller: _codeController!,
          cursorColor: AppColors.primary,
          textStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 20,),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: AppColors.primary,
        onPressed: () async{
          print("Code:");
          print(_codeController?.text);
          String encodedCode = Uri.encodeComponent(_codeController!.text);
          print(encodedCode);
          var response = await api.compileCode(encodedCode, "", _selectedLanguage);
          _showOutputBottomSheet(response);
        },
        child: const Icon(
          Icons.play_arrow_sharp,
        ),
      ),
    );
  }
}
