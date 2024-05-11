import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> addUserDetails(
      {required String username, required String email}) async {
    // Access the current user's UID inside the method
    String doc = auth.currentUser!.uid;
    
    await _firestore.collection("users").doc(doc).set({
      'username': username,
      'email': email,
    });
  }
}
