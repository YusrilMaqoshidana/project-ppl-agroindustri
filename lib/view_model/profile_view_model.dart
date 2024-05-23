import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    String uid = _firebaseAuth.currentUser!.uid;
    return await _firestore.collection("users").doc(uid).get();
  }

  Future<void> updateUsername(String newUsername) async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;
      await _firestore.collection("users").doc(uid).update({
        'username': newUsername,
      });
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}