import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataSensorViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDataSensor(int jumlahHijau, int jumlahMerah, int totalBiji) async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;

      CollectionReference dataSensorCollection = _firestore.collection('users').doc(uid).collection('data_sensor');

      await dataSensorCollection.add({
        'jumlah_hijau': jumlahHijau,
        'jumlah_merah': jumlahMerah,
        'total_biji': totalBiji,
        'waktu': FieldValue.serverTimestamp(),
      });

      print('Data sensor berhasil ditambahkan.');
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  Future<int> getTotalJumlahHijauByMonth(String month) async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;

      CollectionReference dataSensorCollection = _firestore.collection('users').doc(uid).collection('data_sensor');

      QuerySnapshot querySnapshot = await dataSensorCollection.where('waktu', isGreaterThanOrEqualTo: DateTime.parse(month + '-01'), isLessThan: DateTime.parse(month + '-01').add(Duration(days: 31))).get();

      int totalJumlahHijau = 0;
      querySnapshot.docs.forEach((doc) {
        totalJumlahHijau += (doc['hijau']['jumlah_hijau'] as num).toInt();
      });

      return totalJumlahHijau;
    } catch (e) {
      print('Terjadi kesalahan: $e');
      return 0;
    }
  }

  Future<int> getTotalJumlahMerahByMonth(String month) async {
    try {
      // Mendapatkan UID pengguna saat ini
      String uid = _firebaseAuth.currentUser!.uid;

      // Mendapatkan referensi koleksi data_sensor di dalam collection users
      CollectionReference dataSensorCollection = _firestore.collection('users').doc(uid).collection('data_sensor');

      // Membuat query untuk mendapatkan data berdasarkan bulan
      QuerySnapshot querySnapshot = await dataSensorCollection.where('waktu', isGreaterThanOrEqualTo: DateTime.parse(month + '-01'), isLessThan: DateTime.parse(month + '-01').add(Duration(days: 31))).get();

      // Menghitung total jumlah_hijau dari hasil query
      int totalJumlahMerah = 0;
      querySnapshot.docs.forEach((doc) {
        totalJumlahMerah += (doc['merah']['jumlah_merah'] as num).toInt();
      });

      return totalJumlahMerah;
    } catch (e) {
      print('Terjadi kesalahan: $e');
      return 0;
    }
  }
}
