//code editor text field
import 'dart:async';

import 'package:code_text_field/code_text_field.dart';
//flutter default 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//languages import
import 'package:highlight/languages/dart.dart';//It's for dart language
import 'package:highlight/languages/python.dart';//It's for python language
import 'package:highlight/languages/cpp.dart';//It's for c++ language
import 'package:highlight/languages/cs.dart';//It's for computer science language
import 'package:highlight/languages/all.dart';//It's for all language
import 'package:highlight/languages/php.dart';//It's for php language
import 'package:highlight/languages/vue.dart';//It's for vue language
//Editor Themes Packages
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:xterm/theme/terminal_theme.dart';
import 'package:xterm/theme/terminal_themes.dart';
//Terminal package for create terminal
import 'package:xterm/xterm.dart';
//Terminal package for view terminal
import 'package:xterm/flutter.dart';
//pages import
import 'terminal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CodeController? _codeController;
  void onInput() {
    print('input: raihan');
  }

  Map<String, TextStyle>? theme = monokaiSublimeTheme;
  var codes;
  var codeLanguage = cpp;

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    final source =codeLanguage==cpp? "#include<stdio.h> \n int main() \n{\n    printf(\"Raihan Hossain\");\n    printf(\"CSE 9th batch(ccn)\");\n    return 0;\n}":'';
    _codeController = CodeController(
        text: source,
        language: codeLanguage,
        patternMap: {
          r'"*"': TextStyle(color: Colors.pink),
          r'()': TextStyle(color: Colors.green),
        },
        stringMap: {
          "void": TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          "printf": TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          "scanf": TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          "print": TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        },
        theme: theme,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Editor'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.file_download)),

          // Language Select dropdown button

          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Colors.blueGrey,
              elevation: 20,
              icon: Text(_codeController!.languageId,textAlign: TextAlign.center,style: TextStyle(
                color: Colors.white
              ),),
              iconEnabledColor: Colors.white,
              items: <String>['c', 'c++', 'php', 'python','dart']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                      if (value == "c") {
                        codeLanguage = cpp;
                      } else if (value == "c++") {
                        codeLanguage = cpp;
                      } else if (value == "php") {
                        codeLanguage = php;
                      } else if (value == "python") {
                        codeLanguage = python;
                      }else if (value == "dart") {
                        codeLanguage = dart;
                      }
                    }));
                  },
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),

          //customize editor dropdown button

          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: Colors.blueGrey,
              elevation: 20,
              icon: Icon(Icons.color_lens_outlined),
              iconEnabledColor: Colors.white,
              items: <String>['Atom', 'Monokai-sublime', 'VS', 'Darcula']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                      if (value == "Monokai-sublime") {
                        theme = monokaiSublimeTheme;
                      } else if (value == "Atom") {
                        theme = atomOneDarkTheme;
                      } else if (value == "VS") {
                        theme = vsTheme;
                      } else if (value == "Darcula") {
                        theme = darculaTheme;
                      }
                    }));
                  },
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
          SizedBox(width: 20,)
        ],
      ),
      drawer: Drawer(),
      body: ListView(
        children: [
        CodeField(
        controller: _codeController!,
        textStyle: TextStyle(fontFamily: 'SourceCode',fontSize: 20),
          minLines: 10,
      ),

          SizedBox(
            height: 300,
            child: terminalTestR()
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => TerminalPage(codes: _codeController!.text,),));
      },
        child: Icon(Icons.play_arrow,size: 30,),
      ),
    );
  }
}

class terminalTestR extends StatefulWidget {
  const terminalTestR({Key? key}) : super(key: key);

  @override
  State<terminalTestR> createState() => _terminalTestRState();
}

class _terminalTestRState extends State<terminalTestR> {
  final terminal = Terminal(
    backend: FakeTerminalBackend(),
    maxLines: 10000,
    theme: TerminalThemes.whiteOnBlack
  );
  void onInput(String input) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 40,
              child: Column(
                children: [
                  IconButton(onPressed: () {
                    terminal.refresh();
                    terminal.clearSelection();
                  }, icon: Icon(Icons.refresh))
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: TerminalView(
                terminal: terminal,
                style: TerminalStyle(fontFamily: ['Cascadia']),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class FakeTerminalBackend extends TerminalBackend {
  final _exitCodeCompleter = Completer<int>();
  // ignore: close_sinks
  final _outStream = StreamController<String>();

  @override
  Future<int> get exitCode => _exitCodeCompleter.future;

  @override
  void init() {
    _outStream.sink.add('Raihan Hossain compiler');
    _outStream.sink.add('\r\n');
    _outStream.sink.add('\$ ');
  }

  @override
  Stream<String> get out => _outStream.stream;

  @override
  void resize(int width, int height, int pixelWidth, int pixelHeight) {
    // NOOP
  }

  @override
  void write(String input) {
    if (input.length <= 0) {
      return;
    }
    // in a "real" terminal emulation you would connect onInput to the backend
    // (like a pty or ssh connection) that then handles the changes in the
    // terminal.
    // As we don't have a connected backend here we simulate the changes by
    // directly writing to the terminal.
    if (input == '\r') {
      _outStream.sink.add('\r\n');
      _outStream.sink.add('\$ ');
    } else if (input.codeUnitAt(0) == 127) {
      // Backspace handling
      _outStream.sink.add('\b \b');
    } else {
      _outStream.sink.add(input);
    }
  }

  @override
  void terminate() {
    //NOOP
  }

  @override
  void ackProcessed() {
    //NOOP
  }
}