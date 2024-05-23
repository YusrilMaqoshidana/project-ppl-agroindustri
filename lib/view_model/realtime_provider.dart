import 'package:firebase_database/firebase_database.dart';

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

  Stream<DatabaseEvent> getSensorStream() {
  return _databaseReference.child('sensors').onValue;
  }
}
