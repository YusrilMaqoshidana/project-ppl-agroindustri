import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class RealtimeDatabase {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  void statusTombol(bool status) {
    try {
      _databaseReference.child('tombol').set(status);
      print("$status");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<Map<String, dynamic>> getDataSensor() async {
    const url = 'https://gencoff-app-default-rtdb.firebaseio.com/sensors.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
