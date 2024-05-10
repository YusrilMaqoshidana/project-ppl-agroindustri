import 'package:gencoff_app/models/firebase_model.dart';

class LoginViewModel{
  Future<void> signIn(
      {required String email, required String password}) async {
    await FirebaseModel().firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
  }

}