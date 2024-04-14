import 'package:flutter/material.dart';
import 'package:gencoff_app/providers/auth_provider.dart';
import 'package:gencoff_app/utils/long_button.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Map<String, String> profileData = {
    'username': 'Moh. Yusril Maqoshidana',
    'email': '222410102064@mail.unej.ac.id',
    'password': '301103'
  }; // Map untuk menyimpan data profil
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    // Set nilai controller berdasarkan data profil yang telah dibaca
    usernameController.text = profileData['username'] ?? '';
    emailController.text = profileData['email'] ?? '';
    passwordController.text = profileData['password'] ?? '';
  }

  Widget _title() {
    return Center(
      child: Text(
        "Pengaturan",
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return Container(
      margin: EdgeInsets.all(25),
      child: LongButton(text: "Keluar", onPressed: signOut),
    );
  }

  Widget _inputData(TextEditingController controller, String label,
      {String defaultValue = ''}) {
    controller.text = defaultValue; // Set nilai default ke dalam controller
    return Center(
      child: Container(
        width: 350,
        height: 60,
        child: TextField(
          controller: controller,
          enabled: isEdit,
          obscureText: label.toLowerCase() == 'password',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _readData(String? key, Map<String, String> profileData) {
    String? data = profileData[key];
    if (key == 'password') {
      data = '*' * (data?.length ?? 0);
    }
    return Center(
      child: Container(
        width: 350,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 2,
          ), // Menambahkan border
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                data ?? '',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  void _saveProfile() {
    setState(() {
      // Simpan data profil yang diedit ke dalam variabel profileData
      profileData['username'] = usernameController.text;
      profileData['email'] = emailController.text;
      profileData['password'] = passwordController.text;
      isEdit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            icon: Icon(isEdit ? Icons.save : Icons.edit),
            onPressed: isEdit ? _saveProfile : _toggleEdit,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 25),
                child: Text(
                  "Nama",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )),
            !isEdit
                ? _readData('username', profileData)
                : _inputData(usernameController, 'Username',
                    defaultValue: profileData['username'] ?? ''),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 25),
                child: Text(
                  "Email",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )),
            !isEdit
                ? _readData('email', profileData)
                : _inputData(emailController, 'Email',
                    defaultValue: profileData['email'] ?? ''),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 25),
                child: Text(
                  "Password",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )),
            !isEdit
                ? _readData('password', profileData)
                : _inputData(passwordController, 'Password',
                    defaultValue: profileData['password'] ?? ''),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
