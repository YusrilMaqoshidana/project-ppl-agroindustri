import 'package:firebase_auth/firebase_auth.dart';

class LogoutViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
