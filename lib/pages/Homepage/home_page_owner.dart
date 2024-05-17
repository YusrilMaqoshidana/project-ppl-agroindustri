import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/view_model/data_sortir_view_mode.dart';
import 'package:gencoff_app/widgets/alert.dart';
import 'package:gencoff_app/widgets/circle_button.dart';
import 'package:gencoff_app/widgets/long_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _hijauKecilController = TextEditingController();
  final TextEditingController _hijauSedangController = TextEditingController();
  final TextEditingController _hijauBesarController = TextEditingController();
  final TextEditingController _merahKecilController = TextEditingController();
  final TextEditingController _merahSedangController = TextEditingController();
  final TextEditingController _merahBesarController = TextEditingController();
  Map<String, int> dataSensor = {'hijau': 0, 'merah': 0};
  Map<String, int> dataUkuranHijau = {'kecil': 0, 'sedang': 0, 'besar': 0};
  Map<String, int> dataUkuranMerah = {'kecil': 0, 'sedang': 0, 'besar': 0};
  Map<String, int> persentaseDataSensor = {'merah': 0, 'hijau': 0};
  late int totalDataSensor;
  Map<String, int> totalDataUkuran = {'merah': 0, 'hijau': 0};
  late int totalDataSortir;
  bool isEdit = false;
  bool keadaanWifi = false;
  bool keadaanTombol = false;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _initializeValues();
    _readWiFiStatus();
  }

  void _initializeValues() {
    // Isi nilai awal ke dalam variabel-variabel

    _hijauKecilController.text = '0';
    _hijauSedangController.text = '0';
    _hijauBesarController.text = '0';
    _merahKecilController.text = '0';
    _merahSedangController.text = '0';
    _merahBesarController.text = '0';
  }

  void _totalan() {
    isEdit = !isEdit;
    dataUkuranHijau['kecil'] = int.parse(_hijauKecilController.text);
    dataUkuranHijau['sedang'] = int.parse(_hijauSedangController.text);
    dataUkuranHijau['besar'] = int.parse(_hijauBesarController.text);
    dataUkuranMerah['kecil'] = int.parse(_merahKecilController.text);
    dataUkuranMerah['sedang'] = int.parse(_merahSedangController.text);
    dataUkuranMerah['besar'] = int.parse(_merahBesarController.text);
    totalDataSensor =
        dataSensor.values.reduce((value, element) => value + element);
    totalDataUkuran['merah'] =
        dataUkuranMerah.values.reduce((value, element) => value + element);
    totalDataUkuran['hijau'] =
        dataUkuranHijau.values.reduce((value, element) => value + element);
    totalDataSortir =
        totalDataUkuran.values.reduce((value, element) => value + element);
  }

  Widget _title() {
    return const Text(
      "Gencoff",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "Inter",
          fontWeight: FontWeight.w700),
    );
  }

  Widget _wifi(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 25),
        child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/wifi_manager');
            },
            icon: const Icon(
              Icons.wifi,
              color: Colors.white,
            )));
  }
  Widget _dataSensor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Biji Hijau",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 65,
              width: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.brown,
              ),
              child: Center(
                  child: Text(
                "${dataSensor['hijau']}",
                style: const TextStyle(color: Colors.white),
              )),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Biji Merah",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 65,
              width: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.brown,
              ),
              child: Center(
                  child: Text(
                "${dataSensor['merah']}",
                style: const TextStyle(color: Colors.white),
              )),
            )
          ],
        ),
      ],
    );
  }

  Widget _readData(int controller) {
    return Container(
      width: 60,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 2), // Menambahkan border
      ),
      child: Center(
        child: Text(
          "$controller kg",
        ),
      ),
    );
  }

  Widget _textInput(TextEditingController controller) {
    return Container(
      width: 60,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2), // Menambahkan border
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10), // Padding untuk jarak antara teks dan border
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'kg', // Teks yang muncul ketika TextField kosong
            border: InputBorder.none, // Menghilangkan border bawaan TextField
          ),
        ),
      ),
    );
  }

  Future<void> addData() async {
    bool allZeroValues = dataSensor.values.every((value) => value == 0) &&
        dataUkuranHijau.values.every((value) => value == 0) &&
        dataUkuranMerah.values.every((value) => value == 0);
    if (allZeroValues) {
      _showDialogFail("Jangan lupa isi data ukuran anda");
    } else {
      try {
        await DataSortirViewModel().addDataSensor(
            dataSensor,
            dataUkuranMerah,
            dataUkuranHijau,
            totalDataSensor,
            totalDataUkuran,
            totalDataSortir,
            context);
        _showDialogSucces();
        setState(() {
          _initializeValues();
        });
      } catch (e) {
        _showDialogFail("Data gagal ditambahkan");
      }
    }
  }

  void _showDialogSucces() {
    showDialog(
      context: context,
      builder: (context) {
        return SuccesAlertState(
          message: "Berhasil Masuk",
          onPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showDialogFail(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return FailAlertState(
          message: message,
          onPressed: () => Navigator.pop(context),
        );
      },
    );
  }

  void _validateAlert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return ValidationState(
          message: message,
          onPressed: () {
            Navigator.of(context).pop(context);
            addData();
          },
        );
      },
    );
  }

  Widget _cardForm() {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.grey, width: 2)),
        child: Container(
          padding: const EdgeInsets.all(25),
          height: !isEdit ? 400 : 430,
          width: 350,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Data hasil sortir",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                      child: !isEdit
                          ? const Text(
                              "Edit",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Colors.brown),
                            )
                          : const Icon(
                              Icons.cancel,
                              size: 25,
                              color: Colors.red,
                            )),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Ukuran biji hijau",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("Kecil"),
                      !isEdit
                          ? _readData(dataUkuranHijau['kecil']!)
                          : _textInput(_hijauKecilController)
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Sedang"),
                      !isEdit
                          ? _readData(dataUkuranHijau['sedang']!)
                          : _textInput(_hijauSedangController)
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Besar"),
                      !isEdit
                          ? _readData(dataUkuranHijau['besar']!)
                          : _textInput(_hijauBesarController)
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Ukuran biji merah",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(
                  children: [
                    const Text("Kecil"),
                    !isEdit
                        ? _readData(dataUkuranMerah['kecil']!)
                        : _textInput(_merahKecilController)
                  ],
                ),
                Column(
                  children: [
                    const Text("Sedang"),
                    !isEdit
                        ? _readData(dataUkuranMerah['sedang']!)
                        : _textInput(_merahSedangController)
                  ],
                ),
                Column(
                  children: [
                    const Text("Besar"),
                    !isEdit
                        ? _readData(dataUkuranMerah['besar']!)
                        : _textInput(_merahBesarController)
                  ],
                ),
              ]),
              const SizedBox(
                height: 50,
              ),
              !isEdit
                  ? const SizedBox(
                      height: 10,
                    )
                  : LongButton(
                      text: "Simpan",
                      onPressed: () {
                        setState(() {
                          _totalan();
                        });
                      })
            ],
          ),
        ));
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
          !keadaanWifi ? icon[0] : icon[1],
          const SizedBox(
            width: 20,
          ),
          !keadaanWifi ? status[0] : status[1]
        ],
      ),
    );
  }

  Future<void> _readWiFiStatus() async {
    try {
      final DataSnapshot snapshot =
          await _databaseReference.child('wifiStatus').get();
      final data = snapshot.value;
      if (data is bool) {
        // Pindahkan setState() ke luar blok if
        setState(() {
          if (data == true) {
            keadaanWifi = true;
          } else {
            keadaanWifi = false;
          }
        });
      } else {
        setState(() {
          keadaanWifi = false;
        });
      }
    } catch (error) {
      setState(() {
        keadaanWifi = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        actions: [_wifi(context)],
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            _statusKoneksi(context),
            CircleButton(),
            const SizedBox(
              height: 25,
            ),
            _dataSensor(),
            const SizedBox(
              height: 25,
            ),
            _cardForm(),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: !isEdit
                  ? LongButton(
                      text: "Selesai",
                      onPressed: () {
                        _validateAlert(
                            "Apakah anda yakin ingin menambah data?");
                      },
                    )
                  : LongButtonNonAktif(
                      text: "Selesai",
                      onPressed: () {},
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}
