import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gencoff_app/view_model/realtime_provider.dart';
import 'package:gencoff_app/widgets/input.dart';
import 'package:gencoff_app/widgets/long_button.dart';

class WifiManager extends StatefulWidget {
  const WifiManager({super.key});

  @override
  State<WifiManager> createState() => _WifiManagerState();
}

class _WifiManagerState extends State<WifiManager> {
  final databaseReference = FirebaseDatabase.instance.ref();

  final _ssidController = TextEditingController();

  final _passwordController = TextEditingController();
  bool keadaan = false;
  @override
  void initState() {
    super.initState();
    readWiFiStatus();
  }

  Widget _title() {
    return const Text(
      "Wi-fi Manager",
      style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w700,
          color: Colors.white),
    );
  }

  Widget _input() {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        children: [
          InputWithoutIcon(text: "SSID", controller: _ssidController),
          const SizedBox(
            height: 10,
          ),
          InputPassword(text: "Kata sandi", controller: _passwordController)
        ],
      ),
    );
  }

  Widget _statusKoneksi(context) {
    List<Widget> icon = [
      const Icon(
        Icons.wifi_lock,
        color: Colors.white,
      ),
      const Icon(
        Icons.wifi,
        color: Colors.white,
      )
    ];
    List<Widget> status = [
      const Text("Status : Belom Terkoneksi",
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
              color: Colors.white)),
      const Text("Status : Terkoneksi",
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
              color: Colors.white)),
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !keadaan ? icon[0] : icon[1],
          const SizedBox(
            width: 20,
          ),
          !keadaan ? status[0] : status[1]
        ],
      ),
    );
  }

  Widget _buttonKirim() {
    return Container(
        margin: const EdgeInsets.all(25),
        child: LongButton(
          text: "Kirim",
          onPressed: () {
            RealtimeDatabase().addSsidAndPassword(_ssidController.text.trim(),
                _passwordController.text.trim());
            // Panggil readWiFiStatus() setelah berhasil menambahkan ke WiFi
            readWiFiStatus();
          },
        ));
  }

  Future<void> readWiFiStatus() async {
    try {
      final DataSnapshot snapshot =
          await databaseReference.child('wifiStatus').get();
      final data = snapshot.value;
      if (data is bool) {
        // Pindahkan setState() ke luar blok if
        setState(() {
          if (data == true) {
            keadaan = true;
          } else {
            keadaan = false;
          }
        });
      } else {
        setState(() {
          keadaan = false;
        });
      }
    } catch (error) {
      setState(() {
        keadaan = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _statusKoneksi(context),
          const SizedBox(
            height: 50,
          ),
          _input(),
          _buttonKirim()
        ],
      ),
    );
  }
}
