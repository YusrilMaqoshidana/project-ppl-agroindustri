import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase{
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  void statusTombol(bool status) {
    try {
      _databaseReference.child('tombol').set(status);
      print("$status");
    } catch (e) {
      print("Error: $e");
    }
  }

  void resetDataSensor() {
    try {
      _databaseReference.child('sensors/hijau').set(0);
      _databaseReference.child('sensors/merah').set(0);
      print("Berhasil reset data sensor");
    } catch (e) {
      print("Error: $e");
    }
  }

  Stream<DatabaseEvent> getSensorStream() {
    return _databaseReference.child('sensors').onValue;
  }
}
