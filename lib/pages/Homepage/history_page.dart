import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Widget> rekapan = [];
  
  // Konstruktor untuk mengisi list dengan teks data
  _HistoryPageState() {
    for (int i = 10; i < 10; i--) {
      rekapan.add(Text("Data ke-" + i.toString()));
    }
  }

  // Widget untuk judul halaman
  Widget _title() {
    return const Text(
      "Rekapan",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "Inter",
          fontWeight: FontWeight.w700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 253, 253, 100),
      appBar: AppBar(title: _title(), backgroundColor: Colors.brown),
      body: ListView.builder(
        itemCount: rekapan.length,
        itemBuilder: (context, index) => rekapan[index],
      ),
    );
  }
}
