import 'package:flutter/material.dart';
import 'package:flutter_codemirror/flutter_codemirror.dart';


class CodeMirrorView extends StatefulWidget {
  const CodeMirrorView({Key? key}) : super(key: key);

  @override
  State<CodeMirrorView> createState() => _CodeMirrorViewState();
}

class _CodeMirrorViewState extends State<CodeMirrorView> {
  late final CodeMirrorController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Codemirror"),
      ),
      body: CodeMirror(
        onCreated: (CodeMirrorController controller) {
          controller.createItem(
              name: "name",
              props: CodeMirrorProps(
                style: CodeMirrorStyle(fontSize: "14px"),
                theme: CmTheme.oneDark,
                language: CmLanguage.javascript,
              ));
          controller.selectItem(name: "name");
          this.controller = controller;
        },
        onItemReadied: (String name) {
          debugPrint(">>>>>>> onItemReadied: $name");
        },
        onItemUpdated: (String name) async {
          final map = {
            "doc": await controller.doc(name: 'name'),
            "undoDepth": await controller.itemUndoDepth(name: 'name'),
          };
          debugPrint(">>>>>>> onItemUpdated: $name\n$map");
        },
      ),
    );
  }
}