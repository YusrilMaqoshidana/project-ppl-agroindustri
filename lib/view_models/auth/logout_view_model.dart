import 'package:gencoff_app/models/firebase_model.dart';

class Logout{
   Future<void> signOut() async {
    await FirebaseModel().firebaseAuth.signOut();
  }
}