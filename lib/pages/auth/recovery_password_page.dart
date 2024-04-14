import 'package:flutter/material.dart';
import 'package:gencoff_app/utils/long_button.dart';
import 'package:gencoff_app/utils/input.dart';
// import 'package:firebase_auth/firebase_auth.dart';/

class RecoveryPasswordPage extends StatefulWidget {
  RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _passwordConfirmController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword(String newPassword) async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Ganti ini dengan metode untuk mengirim permintaan pengaturan ulang kata sandi
      // ke Firebase Authentication
      // await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      
      // Tampilkan pesan sukses jika berhasil
      _showSuccessDialog("Permintaan pengaturan ulang kata sandi berhasil dikirim");
    } catch (e) {
      // Tangani kesalahan jika terjadi
      _showErrorDialog("Terjadi kesalahan: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    setState(() {
      _errorMessage = message;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
            child: Column(
              children: [
                Text(
                  "Pemulihan Password",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password baru",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputPassword(
                      text: "Masukan Password",
                      controller: _passwordController,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Konfirmasi password",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputPassword(
                      text: "Masukan Password",
                      controller: _passwordConfirmController,
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : LongButton(
                        text: "Simpan",
                        onPressed: () {
                          String newPassword = _passwordController.text.trim();
                          String confirmPassword = _passwordConfirmController.text.trim();

                          if (newPassword.isNotEmpty && confirmPassword.isNotEmpty) {
                            if (newPassword == confirmPassword) {
                              _resetPassword(newPassword);
                            } else {
                              _showErrorDialog("Password dan konfirmasi password tidak cocok");
                            }
                          } else {
                            _showErrorDialog("Mohon masukkan password");
                          }
                        },
                      ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
