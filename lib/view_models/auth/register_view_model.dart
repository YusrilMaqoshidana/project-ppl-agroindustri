import 'package:gencoff_app/models/firebase_model.dart';

class RegisterViewModel{
  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await FirebaseModel().firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
  Future<void> addUserDetails(
      {required String username, required String email}) async {
    await FirebaseModel().firestore.collection("users").doc(FirebaseModel().uid).set({
      'username': username,
      'email': email,
    });
  }
}