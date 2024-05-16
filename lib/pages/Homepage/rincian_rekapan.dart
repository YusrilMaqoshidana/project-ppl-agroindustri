import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gencoff_app/view_model/firebase_provider.dart';

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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('Data tidak ditemukan.'),
            );
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(25),
                  child: Text(
                    "Hasil Rekapan Bulan ${widget.bulan}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              _buildDataItem('Data Sensor', data['data_sensor'], 'Biji'),
              _buildDataItem(
                  'Data Ukuran Hijau', data['data_ukuran_hijau'], 'Kg'),
              _buildDataItem(
                  'Data Ukuran Merah', data['data_ukuran_merah'], 'Kg'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDataItem(
      String title, Map<String, dynamic> data, String kuantity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        ...data.entries.map((entry) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(entry.key),
              Text('${entry.value.toString()} $kuantity'),
            ],
          );
        }).toList(),
        const Divider(),
      ],
    );
  }
}
