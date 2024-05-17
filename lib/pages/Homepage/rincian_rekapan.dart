import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gencoff_app/view_model/firebase_provider.dart';
import 'package:gencoff_app/widgets/card_history.dart';

class RincianPage extends StatefulWidget {
  final String documentId;
  final String bulan;
  const RincianPage({super.key, required this.documentId, required this.bulan});

  @override
  State<RincianPage> createState() => _RincianPageState();
}

Widget _title() {
  return const Text(
    "Rincian Rekapitulasi",
    style: TextStyle(
        color: Colors.white, fontFamily: "Inter", fontWeight: FontWeight.w700),
  );
}

class _RincianPageState extends State<RincianPage> {
  String uid = Firebase().currentUser!.uid;
  int persentaseMerah = 0;
  int persentaseHijau = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        backgroundColor: Colors.brown,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('data_hasil_sortir')
            .doc(widget.documentId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('Data tidak ditemukan.'),
            );
          }
          var data = snapshot.data!.data() as Map<String, dynamic>;
          int jumlahBijiHijau = (data['data_sensor']['hijau'] as num).toInt();
          int jumlahBijiMerah = (data['data_sensor']['merah'] as num).toInt();
          if (jumlahBijiHijau != 0 || jumlahBijiMerah != 0) {
            double persentaseHijauDouble =
                (data['data_sensor']['hijau'] / data['total_data_sensor']) *
                    100;
            double persentaseMerahDouble =
                (data['data_sensor']['merah'] / data['total_data_sensor']) *
                    100;
            persentaseHijau = persentaseHijauDouble.toInt();
            persentaseMerah = persentaseMerahDouble.toInt();
            // Lakukan sesuatu dengan persentaseHijau
          }
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(25),
                  child: Text(
                    "Hasil Rekapan Bulan ${widget.bulan}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              CardHistoryWidget(
                  persentaseHijau: persentaseHijau,
                  persentaseMerah: persentaseMerah,
                  jumlahBiji: data['data_sensor'],
                  totalJumlahBiji: data['total_data_sensor'],
                  ukuranMerah: data['data_ukuran_merah'],
                  ukuranHijau: data['data_ukuran_hijau'],
                  totalBeratMerah: data['total_data_ukuran']['merah'],
                  totalBeratHijau: data['total_data_ukuran']['hijau'],
                  totalHasilSortir: data['total_data_sortir'])
            ],
          );
        },
      ),
    );
  }
}
