import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    notifyListeners();
  }
  
  Future<void> addUserDetails(
      {required String username, required String email}) async {
    String uid = _firebaseAuth.currentUser!.uid;
    await _firestore.collection("users").doc(uid).set({
      'username': username,
      'email': email,
    });
  }
}