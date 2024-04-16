import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> addUserDetails({required String username, required String email}) async {
    String uid = _firebaseAuth.currentUser!.uid;
    await _firestore.collection("users").doc(uid).set({
      'username': username,
      'email': email,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _firestore.collection("users").doc(uid).get();
  }
}
