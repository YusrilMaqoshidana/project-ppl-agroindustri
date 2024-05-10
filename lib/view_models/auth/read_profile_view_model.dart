import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gencoff_app/models/firebase_model.dart';

class ReadProfileViewModel{
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseModel().firestore.collection("users").doc(FirebaseModel().uid).get();
  }
}