import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorData extends ChangeNotifier {
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('sensors');
  SensorData() {
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        _data = Map<String, dynamic>.from(event.snapshot.value as Map);
        notifyListeners();
      }
    });
  }
}
