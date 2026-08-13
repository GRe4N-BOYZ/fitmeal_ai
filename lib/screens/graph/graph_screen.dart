import 'package:flutter/material.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("グラフ"),
      ),
      body: Center(
        child: Text(
          "グラフ画面",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}