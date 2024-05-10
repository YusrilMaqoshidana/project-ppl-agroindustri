import 'package:flutter/material.dart';
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
  final Map<String, int> _bijiHijau = {
    'kecil': 0,
    'sedang': 0,
    'besar': 0,
  };
  final Map<String, int> _bijiMerah = {
    'kecil': 0,
    'sedang': 0,
    'besar': 0,
  };
  bool isEdit = false;
  Widget _title() {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      child: const Text(
        "Gencoff",
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Inter",
            fontWeight: FontWeight.w700),
      ),
    );
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
                  child: const Text(
                "0",
                style: TextStyle(color: Colors.white),
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
                  child: const Text(
                "0",
                style: TextStyle(color: Colors.white),
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

  Widget _cardForm() {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.grey, width: 2)),
        child: AnimatedContainer(
          padding: const EdgeInsets.all(25),
          height: !isEdit ? 400 : 430,
          width: 350,
          decoration: BoxDecoration(color: Colors.white),
          duration: const Duration(seconds: 1),
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
                          ? _readData(_bijiHijau['kecil']!)
                          : _textInput(_hijauKecilController)
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Sedang"),
                      !isEdit
                          ? _readData(_bijiHijau['sedang']!)
                          : _textInput(_hijauSedangController)
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Besar"),
                      !isEdit
                          ? _readData(_bijiHijau['besar']!)
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
                        ? _readData(_bijiMerah['kecil']!)
                        : _textInput(_merahKecilController)
                  ],
                ),
                Column(
                  children: [
                    const Text("Sedang"),
                    !isEdit
                        ? _readData(_bijiMerah['sedang']!)
                        : _textInput(_merahSedangController)
                  ],
                ),
                Column(
                  children: [
                    const Text("Besar"),
                    !isEdit
                        ? _readData(_bijiMerah['besar']!)
                        : _textInput(_merahBesarController)
                  ],
                ),
              ]),
              const SizedBox(
                height: 50,
              ),
              !isEdit
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.lock)])
                  : LongButton(
                      text: "Simpan",
                      onPressed: () {
                        setState(() {
                          _bijiHijau['kecil'] =
                              int.parse(_hijauKecilController.text);
                          _bijiHijau['sedang'] =
                              int.parse(_hijauSedangController.text);
                          _bijiHijau['besar'] =
                              int.parse(_hijauBesarController.text);
                          _bijiMerah['kecil'] =
                              int.parse(_merahKecilController.text);
                          _bijiMerah['sedang'] =
                              int.parse(_merahSedangController.text);
                          _bijiMerah['besar'] =
                              int.parse(_merahBesarController.text);
                          isEdit = !isEdit;
                        });
                      })
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
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
                        })
                    : const LongButtonNonAktif(text: "Selesai")),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}
