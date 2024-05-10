import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseModel {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String uid = FirebaseModel().firebaseAuth.currentUser!.uid;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
}
