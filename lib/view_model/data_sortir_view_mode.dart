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
    int totalDataSensor,
    Map<String, int> totalDataUkuran,
    int totalDataSortir,
    BuildContext context,
  ) async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;
      CollectionReference dataSensorCollection = _firestore
          .collection('users')
          .doc(uid)
          .collection('data_hasil_sortir');
      // Ambil bulan dan tahun saat ini
      DateTime now = DateTime.now();
      int currentMonth = now.month;
      int currentYear = now.year;
      // Cek apakah ada data dengan bulan dan tahun yang sama
      QuerySnapshot snapshot = await dataSensorCollection
          .where('bulan', isEqualTo: currentMonth)
          .where('tahun', isEqualTo: currentYear)
          .get();
      SortingData sortingData = SortingData(
        dataSensor,
        merah,
        hijau,
        totalDataSensor,
        totalDataUkuran,
        totalDataSortir,
        currentMonth,
        currentYear,
      );
      if (snapshot.docs.isNotEmpty) {
        // Jika ada, update data yang ada dengan data baru
        DocumentSnapshot document = snapshot.docs.first;
        Map<String, dynamic> existingData =
            document.data() as Map<String, dynamic>;
        // Update dataSensor
        dataSensor.forEach((sizeCategory, sizeCount) {
          if (existingData['data_sensor'].containsKey(sizeCategory)) {
            existingData['data_sensor'][sizeCategory] += sizeCount;
          } else {
            existingData['data_sensor'][sizeCategory] = sizeCount;
          }
        });
        // Update merah
        merah.forEach((sizeCategory, sizeCount) {
          if (existingData['data_ukuran_merah'].containsKey(sizeCategory)) {
            existingData['data_ukuran_merah'][sizeCategory] += sizeCount;
          } else {
            existingData['data_ukuran_merah'][sizeCategory] = sizeCount;
          }
        });
        // Update hijau
        hijau.forEach((sizeCategory, sizeCount) {
          if (existingData['data_ukuran_hijau'].containsKey(sizeCategory)) {
            existingData['data_ukuran_hijau'][sizeCategory] += sizeCount;
          } else {
            existingData['data_ukuran_hijau'][sizeCategory] = sizeCount;
          }
        });
        // Update totalDataSensor
        existingData['total_data_sensor'] =
            existingData['total_data_sensor'] + totalDataSensor;

        // Update totalDataUkuran
        totalDataUkuran.forEach((sizeCategory, sizeCount) {
          if (existingData['total_data_ukuran'].containsKey(sizeCategory)) {
            existingData['total_data_ukuran'][sizeCategory] += sizeCount;
          } else {
            existingData['total_data_ukuran'][sizeCategory] = sizeCount;
          }
        });
        // Update totalDataSortir
        existingData['total_data_sortir'] =
            existingData['total_data_sortir'] + totalDataSortir;

        // Update dokumen yang ada dengan data yang telah disesuaikan
        await document.reference.update(existingData);
      } else {
        // Jika tidak ada data dengan bulan dan tahun yang sama, tambahkan dokumen baru
        await dataSensorCollection.add({
          ...sortingData.toMap(),
          'waktu': FieldValue.serverTimestamp(),
        });
      }
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
