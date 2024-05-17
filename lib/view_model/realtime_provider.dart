import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  void addSsidAndPassword(String ssid, String password) {
    try {
      _databaseReference
          .child('wifi')
          .set({'ssid': ssid, 'password': password});
    } catch (e) {
      print("Error: $e");
    }
  }

  void statusTombol(bool status) {
    try {
      _databaseReference.child('tombol').set(status);
      print("$status");
    } catch (e) {
      print("Error: $e");
    }
  }
}
