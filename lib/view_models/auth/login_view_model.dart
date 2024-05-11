import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signIn({required String email, required String password}) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
