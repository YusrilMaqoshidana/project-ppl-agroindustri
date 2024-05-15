import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataSensorViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDataSensor( Map<String, int> hijau, Map<String, int> merah) async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;

      CollectionReference dataSensorCollection = _firestore.collection('users').doc(uid).collection('ukuran_biji');

      await dataSensorCollection.add({
        'hijau': hijau,
        'merah': merah,
        'waktu': FieldValue.serverTimestamp(), // Menambahkan informasi waktu saat ini
      });
      print('Data sensor berhasil ditambahkan.');
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }
}
