import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gencoff_app/pages/Homepage/rincian_rekapan.dart';
import 'package:gencoff_app/view_model/firebase_provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

  Widget _title() {
    return const Text(
      "Laporan Hasil Sortir",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "Inter",
          fontWeight: FontWeight.w700),
    );
  }
class _HistoryPageState extends State<HistoryPage> {

  String uid = Firebase().currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 253, 253, 100),
      appBar: AppBar(
        title: _title(),
        backgroundColor: Colors.brown,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('data_hasil_sortir')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Belum ada data sortir.'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var bulan = doc['waktu'].toDate().month;
              var namabulan = _getNamaBulan(bulan);
              return Card(
                child: ListTile(
                  title: Text('Sortiran Bulan $namabulan'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RincianPage(documentId: doc.id, bulan: namabulan,)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _getNamaBulan(int bulan) {
    switch (bulan) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
