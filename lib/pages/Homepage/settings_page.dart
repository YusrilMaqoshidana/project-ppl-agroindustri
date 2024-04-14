import 'package:flutter/material.dart';
import 'package:gencoff_app/providers/auth_provider.dart';
import 'package:gencoff_app/utils/long_button.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Map<String, String> profileData = {}; // Map untuk menyimpan data profil
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isEdit = false;

  Widget _title() {
    return Center(
        child: Text(
      "Pengaturan",
      style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w700,
          color: Colors.white),
    ));
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return Container(
        margin: EdgeInsets.all(25),
        child: LongButton(text: "Keluar", onPressed: signOut));
  }

  Widget _readData(TextEditingController controller, String label, {String defaultValue = ''}) {
    controller.text = defaultValue; // Set nilai default ke dalam controller
    return Container(
      width: 250,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        enabled: isEdit,
        obscureText: label.toLowerCase() == 'password',
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
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
    // Baca data profil saat pertama kali halaman dimuat
    // profileData = readProfile(); // Implementasikan fungsi ini sesuai dengan metode pembacaan yang digunakan

    // Set nilai controller berdasarkan data profil yang telah dibaca
    usernameController.text = profileData['username'] ?? '';
    emailController.text = profileData['email'] ?? '';
    passwordController.text = profileData['password'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: _title(),
        backgroundColor: Colors.brown,
        actions: [
          !isEdit ? IconButton(
            icon: Icon(Icons.edit),
            onPressed: _toggleEdit,
          ) :
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveProfile,
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _readData(usernameController, 'Username', defaultValue: profileData['username'] ?? 'Moh. Yusril Maqoshidana'),
            _readData(emailController, 'Email', defaultValue: profileData['email'] ?? '222410102064@mail.unej.ac.id'),
            _readData(passwordController, 'Password', defaultValue: profileData['password'] ?? '******'),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
