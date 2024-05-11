import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firebase extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    notifyListeners();
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> addUserDetails(
      {required String username, required String email}) async {
    String uid = _firebaseAuth.currentUser!.uid;
    await _firestore.collection("users").doc(uid).set({
      'username': username,
      'email': email,
    });
    notifyListeners();
  }

  Future<void> updateEmail(String newEmail) async {
    await _firebaseAuth.currentUser?.verifyBeforeUpdateEmail(newEmail);
    // Update email in Firestore
    String uid = _firebaseAuth.currentUser!.uid;
    await _firestore.collection("users").doc(uid).update({
      'email': newEmail,
    });
    notifyListeners();
  }

  Future<void> updateUsername(String newUsername) async {
    String uid = currentUser!.uid;
    await _firestore.collection("users").doc(uid).update({
      'username': newUsername,
    });
    notifyListeners();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _firestore.collection("users").doc(uid).get();
  }
}
