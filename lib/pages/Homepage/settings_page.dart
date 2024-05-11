import 'package:flutter/material.dart';
import 'package:gencoff_app/view_model/firebase_provider.dart';
import 'package:gencoff_app/widgets/long_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

bool editUsername = false;
bool editEmail = false;
final newUsername = TextEditingController();
final newEmail = TextEditingController();

Widget _title() {
  return const Text(
    "Settings",
    style: TextStyle(
        color: Colors.white, fontFamily: "Inter", fontWeight: FontWeight.w700),
  );
}

Widget _textBox(String subjudul, String data, VoidCallback onPressed) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.only(left: 15, bottom: 15),
    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subjudul,
              style: TextStyle(color: Colors.grey[500]),
            ),
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                ))
          ],
        ),
        Text(data),
      ],
    ),
  );
}

Widget _textField(
    String subjudul, TextEditingController controller, String data) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.only(left: 15, bottom: 15),
    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subjudul,
          style: TextStyle(color: Colors.grey[500]),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: data),
        ),
      ],
    ),
  );
}

Future<void> signOut() async {
  await Firebase().signOut();
}

Widget _signOutButton() {
  return Container(
    margin: const EdgeInsets.all(25),
    child: const LongButton(text: "Keluar", onPressed: signOut),
  );
}

class _SettingsPageState extends State<SettingsPage> {
  Map<String, dynamic> _dataUser = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final userData = await Firebase().getUserDetails();
      setState(() {
        _dataUser = userData.data() as Map<String, dynamic>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false; // Setelah data gagal dimuat, tidak lagi loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(
          title: _title(),
          backgroundColor: Colors.brown,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 700,
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Icon(
                      Icons.person,
                      size: 72,
                      color: Colors.brown,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "P R O F I L",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    !editUsername
                        ? _textBox("Nama Lengkap", _dataUser['username'], () {
                            setState(() {
                              editUsername = !editUsername;
                            });
                          })
                        : _textField(
                            "Nama Lengkap", newUsername, _dataUser['username']),
                    !editUsername
                        ? const SizedBox(
                            height: 0,
                          )
                        : Container(
                        margin: const EdgeInsets.all(25),
                        child: LongButton(
                            text: "Simpan",
                            onPressed: () {
                              setState(() {
                                Firebase().updateUsername(newUsername.text.trim());
                                editUsername = !editUsername;
                              });
                            })),
                    !editEmail
                        ? _textBox("Alamat Email", _dataUser['email'], () {
                            setState(() {
                              Firebase().updateEmail(newEmail.text.trim());
                              editEmail = !editEmail;
                            });
                          })
                        : _textField(
                            "Alamat Email", newEmail, _dataUser['email']),
                    !editEmail
                        ? const SizedBox(
                            height: 0,
                          )
                        : Container(
                            margin: const EdgeInsets.all(25),
                            child: LongButton(
                                text: "Simpan",
                                onPressed: () {
                                  setState(() {
                                    editEmail = !editEmail;
                                  });
                                })),
                  ],
                ),
                _signOutButton()
              ],
            ),
          ),
        ),
      );
    }
  }
}
