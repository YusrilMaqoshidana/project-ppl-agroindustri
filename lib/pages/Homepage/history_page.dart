import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  

  Widget _title() {
  return const Text(
    "Rekapan",
    style: TextStyle(
        color: Colors.white, fontFamily: "Inter", fontWeight: FontWeight.w700),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        backgroundColor: Colors.brown
      ),
      body: ListView(children: [
        Text("HistoryPage"),
      ]),
    );
  }
}
