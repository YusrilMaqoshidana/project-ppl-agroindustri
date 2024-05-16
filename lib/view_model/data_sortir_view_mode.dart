import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gencoff_app/models/data_sortir.dart';
import 'package:gencoff_app/widgets/alert.dart';

class DataSortirViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDataSensor(
    Map<String, int> dataSensor,
    Map<String, int> merah,
    Map<String, int> hijau,
    BuildContext context,
  ) async {
    // Check if any data is zero
    if (dataSensor.containsValue(0) && merah.containsValue(0) && hijau.containsValue(0)) {
      FailAlertState(
        message: "Data gagal ditambahkan",
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      try {
        String uid = _firebaseAuth.currentUser!.uid;

        CollectionReference dataSensorCollection = _firestore
            .collection('users')
            .doc(uid)
            .collection('data_hasil_sortir');

        // Create a SortingData object
        SortingData sortingData = SortingData(
          dataSensor: dataSensor,
          merah: merah,
          hijau: hijau,
        );

        // Convert SortingData to a map and add to Firestore
        await dataSensorCollection.add({
          ...sortingData.toMap(), // Spread operator to add map elements
          'waktu': FieldValue.serverTimestamp(),
        });

        SuccesAlertState(
          message: "Data berhasil ditambahkan",
          onPressed: () {
            Navigator.pop(context);
          },
        );
      } catch (e) {
        FailAlertState(
          message: "Data gagal ditambahkan",
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }
    }
  }


Future<List<Map<String, dynamic>>> getDataSensor(String uid) async {
  List<Map<String, dynamic>> sensorData = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('data_hasil_sortir')
        .get();

    querySnapshot.docs.forEach((doc) {
      // Ambil data sensor dari dokumen dan tambahkan ke daftar sensorData
      sensorData.add(doc.data() as Map<String, dynamic>);
    });

    return sensorData;
  } catch (e) {
    print("Error fetching sensor data: $e");
    return [];
  }
}

}
