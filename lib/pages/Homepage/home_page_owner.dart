import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gencoff_app/view_model/data_ukuran_view_mode.dart';
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
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    _initializeValues();
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

  Widget _buttonCircle() {
    return CircleButton(onPress: () {});
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
    if (dataSensor.containsValue(0) &&
        dataUkuranHijau.containsValue(0) &&
        dataUkuranMerah.containsValue(0)) {
      _showDialogFail("Jangan lupa isi data ukuran anda");
    } else {
      try {
        await DataSortirViewModel().addDataSensor(
            dataSensor, dataUkuranHijau, dataUkuranMerah, context);
        _showDialogSucces();
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
          onPressed: () => Navigator.pop(context),
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
                          isEdit = !isEdit;
                          dataUkuranHijau['kecil'] =
                              int.parse(_hijauKecilController.text);
                          dataUkuranHijau['sedang'] =
                              int.parse(_hijauSedangController.text);
                          dataUkuranHijau['besar'] =
                              int.parse(_hijauBesarController.text);
                          dataUkuranMerah['kecil'] =
                              int.parse(_merahKecilController.text);
                          dataUkuranMerah['sedang'] =
                              int.parse(_merahSedangController.text);
                          dataUkuranMerah['besar'] =
                              int.parse(_merahBesarController.text);
                        });
                      })
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 253, 253, 100),
      appBar: AppBar(
        title: _title(),
        actions: [_wifi(context)],
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            _buttonCircle(),
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
