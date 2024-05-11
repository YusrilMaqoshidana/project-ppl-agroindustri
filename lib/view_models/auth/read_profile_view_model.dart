import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReadProfileViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String doc = FirebaseAuth.instance.currentUser!.uid;
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await _firestore.collection("users").doc(doc).get();
  }
}
