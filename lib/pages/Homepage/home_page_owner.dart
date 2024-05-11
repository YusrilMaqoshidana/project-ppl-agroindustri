import 'package:flutter/material.dart';
import 'package:gencoff_app/widgets/circle_button.dart';
import 'package:gencoff_app/widgets/long_button.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

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
  Map<String, int> _ukuranBiji = {
    'hijauKecil': 0,
    'hijauSedang': 0,
    'hijauBesar': 0,
    'merahKecil': 0,
    'merahSedang': 0,
    'merahBesar': 0,
  };
  bool isEdit = false;

  Widget _title() {
    return Container(
      margin: EdgeInsets.only(left: 25),
      child: Text(
        "Gencoff",
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Inter",
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _wifi(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 25),
        child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/wifi_manager');
            },
            icon: Icon(
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
            Text(
              "Biji Hijau",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 65,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.brown,
              ),
              child: Center(
                  child: Text(
                "${_ukuranBiji['hijauKecil']}",
                style: TextStyle(color: Colors.white),
              )),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Biji Merah",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 65,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.brown,
              ),
              child: Center(
                  child: Text(
                "${_ukuranBiji['merahKecil']}",
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
          decoration: InputDecoration(
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
            side: BorderSide(color: Colors.grey, width: 2)),
        child: Container(
          padding: EdgeInsets.all(25),
          height: !isEdit ? 400 : 430,
          width: 350,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
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
                          ? Text(
                              "Edit",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  color: Colors.brown),
                            )
                          : Icon(
                              Icons.cancel,
                              size: 25,
                              color: Colors.red,
                            )),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Ukuran biji hijau",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Kecil"),
                      !isEdit
                          ? _readData(_ukuranBiji['hijauKecil']!)
                          : _textInput(_hijauKecilController)
                    ],
                  ),
                  Column(
                    children: [
                      Text("Sedang"),
                      !isEdit
                          ? _readData(_ukuranBiji['hijauSedang']!)
                          : _textInput(_hijauSedangController)
                    ],
                  ),
                  Column(
                    children: [
                      Text("Besar"),
                      !isEdit
                          ? _readData(_ukuranBiji['hijauBesar']!)
                          : _textInput(_hijauBesarController)
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Ukuran biji merah",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(
                  children: [
                    Text("Kecil"),
                    !isEdit
                        ? _readData(_ukuranBiji['merahKecil']!)
                        : _textInput(_merahKecilController)
                  ],
                ),
                Column(
                  children: [
                    Text("Sedang"),
                    !isEdit
                        ? _readData(_ukuranBiji['merahSedang']!)
                        : _textInput(_merahSedangController)
                  ],
                ),
                Column(
                  children: [
                    Text("Besar"),
                    !isEdit
                        ? _readData(_ukuranBiji['merahBesar']!)
                        : _textInput(_merahBesarController)
                  ],
                ),
              ]),
              SizedBox(
                height: 50,
              ),
              !isEdit
                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.lock)])
                  : LongButton(
                      text: "Simpan",
                      onPressed: () {
                        setState(() {
                          _ukuranBiji['hijauKecil'] = int.parse(_hijauKecilController.text);
                          _ukuranBiji['hijauSedang'] = int.parse(_hijauSedangController.text);
                          _ukuranBiji['hijauBesar'] = int.parse(_hijauBesarController.text);
                          _ukuranBiji['merahKecil'] = int.parse(_merahKecilController.text);
                          _ukuranBiji['merahSedang'] = int.parse(_merahSedangController.text);
                          _ukuranBiji['merahBesar'] = int.parse(_merahBesarController.text);
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
        actions: [_wifi(context)],
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            _buttonCircle(),
            SizedBox(
              height: 25,
            ),
            _dataSensor(),
            SizedBox(
              height: 25,
            ),
            _cardForm(),
            SizedBox(height: 20,),
            Container(margin: EdgeInsets.all(25),child: !isEdit ? LongButton(text: "Selesai", onPressed: (){}) : LongButtonNonAktif(text: "Selesai")),
            SizedBox(height: 20,),
          ],
        )),
      ),
    );
  }
}
