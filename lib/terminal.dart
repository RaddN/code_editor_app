import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TerminalPage extends StatefulWidget {
 final codes;

  const TerminalPage({super.key, required this.codes});

  @override
  State<TerminalPage> createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Text(widget.codes),
      
    );
  }
}
