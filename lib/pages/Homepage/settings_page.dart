import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gencoff_app/view_model/firebase_provider.dart';
import 'package:gencoff_app/widgets/alert.dart';
import 'package:gencoff_app/widgets/long_button.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

TextEditingController valueController = TextEditingController();
bool _isEdit = false;
late User? currentUser;
final users = FirebaseFirestore.instance.collection("users");

Widget _title() {
  return const Text(
    "Pengaturan",
    style: TextStyle(
        color: Colors.white, fontFamily: "Inter", fontWeight: FontWeight.w700),
  );
}

Widget _textBox(String subjudul, String data, {IconButton? iconButton}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
          color: Colors.grey.withOpacity(0.5), width: 2), // Menambahkan border
    ),
    padding: const EdgeInsets.only(left: 15, bottom: 15),
    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                subjudul,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            iconButton ?? const SizedBox(),
          ],
        ),
        Text(
          data,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

Widget _textField(String subjudul) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
          color: Colors.grey.withOpacity(0.5), width: 2), // Menambahkan border
    ),
    padding: const EdgeInsets.only(left: 15, bottom: 15),
    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            subjudul,
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextField(
          controller: valueController,
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          decoration: InputDecoration(
              hintText: "Masukan nama baru",
              hintStyle: TextStyle(color: Colors.grey)),
        ),
      ],
    ),
  );
}

Future<void> signOut() async {
  await Firebase().signOut();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    currentUser = Firebase().currentUser;
  }

  Future<void> _updateUsername() async {
    if (valueController.text.isEmpty) {
      FailAlertState(
        message: "Pastikan input nama tidak kosong",
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      try {
        // Perbarui nama pengguna di Firebase Auth
        await Firebase().updateUsername(valueController.text.trim());

        // Perbarui nama pengguna di Firestore
        await users
            .doc(currentUser?.uid)
            .update({'username': valueController.text});

        // Setelah data diperbarui, kembali ke tampilan non-edit
        setState(() {
          _isEdit = !_isEdit;
        });
      } catch (error) {
        print("Gagal memperbarui nama pengguna: $error");
        // Tampilkan pesan kesalahan jika gagal memperbarui
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        backgroundColor: Colors.brown,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(child: _textBox("Email:", userData['email'])),
                _isEdit
                    ? _textBox("Nama:", userData['username'],
                        iconButton: IconButton(
                            onPressed: () {
                              setState(() {
                                _isEdit = !_isEdit;
                              });
                            },
                            icon: const Icon(Icons.edit)))
                    : _textField("Nama:"),
                !_isEdit
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: 150,
                            child: LongButtonNonAktif(
                                text: "Batal",
                                onPressed: () {
                                  setState(() {
                                    _isEdit = !_isEdit;
                                  });
                                }),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: 150,
                            child: LongButton(
                                text: "Simpan",
                                onPressed: () {
                                  _updateUsername();
                                }),
                          )
                        ],
                      )
                    : const SizedBox(
                        height: 40,
                      ),
                const SizedBox(
                  height: 150,
                ),
                _isEdit
                    ? Container(
                        margin: const EdgeInsets.all(25),
                        child: LongButton(
                            text: "Keluar",
                            onPressed: () {
                              signOut();
                            }),
                      )
                    : SizedBox()
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error" + snapshot.error.toString()),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
