import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gencoff_app/widgets/alert.dart';

class RekapanBulananViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<void> tambahRekapanBulanan(BuildContext context) async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;
      String tahunBulan = _getTahunBulan();
      Map<String, dynamic> rekapanBulanan = await _hitungRekapanBulanan(uid);

      CollectionReference rekapanBulananCollection = _firestore
          .collection('users')
          .doc(uid)
          .collection('rekapan_bulanan');

      await rekapanBulananCollection.doc(tahunBulan).set(rekapanBulanan);
      SuccesAlertState(
          message: "Rekapan bulanan berhasil ditambahkan",
          onPressed: () {
            Navigator.pop(context);
          });
    } catch (e) {
      FailAlertState(
          message: "Gagal menambahkan rekapan bulanan",
          onPressed: () {
            Navigator.pop(context);
          });
    }
  }

  String _getTahunBulan() {
    DateTime now = DateTime.now();
    return "${now.year}-${now.month}";
  }

  Future<Map<String, dynamic>> _hitungRekapanBulanan(String uid) async {
    int totalBiji = 0;
    int totalBijiHijau = 0;
    int totalBijiMerah = 0;
    int totalBeratSortir = 0;
    int totalBeratHijau = 0;
    int totalBeratMerah = 0;

    QuerySnapshot result = await _firestore
        .collection('users')
        .doc(uid)
        .collection('data_hasil_sortir')
        .get();

    result.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Map<String, int> dataSensor = data['data_sensor'];
      Map<String, int> merah = data['data_ukuran_merah'];
      Map<String, int> hijau = data['data_ukuran_hijau'];

      totalBiji += dataSensor.length;
      totalBijiHijau += merah.length;
      totalBijiMerah += hijau.length;

      dataSensor.forEach((key, value) {
        totalBeratSortir += value;
      });

      merah.forEach((key, value) {
        totalBeratMerah += value;
      });

      hijau.forEach((key, value) {
        totalBeratHijau += value;
      });
    });

    double persentaseHijau = (totalBijiHijau / totalBiji) * 100;
    double persentaseMerah = (totalBijiMerah / totalBiji) * 100;

    Map<String, dynamic> rekapanBulanan = {
      'tahun': DateTime.now().year.toString(),
      'bulan': DateTime.now().month.toString(),
      'jumlah_biji': {'total': totalBiji, 'hijau': totalBijiHijau, 'merah': totalBijiMerah},
      'persentase': {'hijau': persentaseHijau, 'merah': persentaseMerah},
      'total_berat_sortir': totalBeratSortir,
      'total_berat_hijau': totalBeratHijau,
      'total_berat_merah': totalBeratMerah,
    };

    return rekapanBulanan;
  }
}
