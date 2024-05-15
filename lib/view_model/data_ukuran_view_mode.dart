import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gencoff_app/widgets/alert.dart';

class DataSortirViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDataSensor(
      Map<String, int> dataSensor,
      Map<String, int> merah,
      Map<String, int> hijau,
      BuildContext context) async {
    if (dataSensor.containsValue(0) &&
        merah.containsValue(0) &&
        hijau.containsValue(0)) {
      FailAlertState(
          message: "Data gagal ditambahkan",
          onPressed: () {
            Navigator.pop(context);
          });
    } else {
      try {
        String uid = _firebaseAuth.currentUser!.uid;

        CollectionReference dataSensorCollection = _firestore
            .collection('users')
            .doc(uid)
            .collection('data_hasil_sortir');

        await dataSensorCollection.add({
          'data_sensor': dataSensor,
          'data_ukuran_hijau': merah,
          'data_ukuran_merah': hijau,
          'waktu': FieldValue
              .serverTimestamp(), // Menambahkan informasi waktu saat ini
        });
        SuccesAlertState(
            message: "Data berhasil ditambahkan", onPressed: () {Navigator.pop(context);});
      } catch (e) {
        FailAlertState(message: "Data gagal ditambahkan", onPressed: () {Navigator.pop(context);});
      }
    }
  }
}
