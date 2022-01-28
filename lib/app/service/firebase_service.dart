import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  Future<bool> checkUserAlreadyLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print('User Uid : ' + auth.currentUser!.uid);
      return true;
    } else {
      return false;
    }
  }

  Future userSetup(User user, String displayName) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String uid = user.uid.toString();
    users.doc(uid).set({
      'displayName': displayName,
      'uid': uid,
      'email': user.email,
      'lastLogin': user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      'createdAt': user.metadata.creationTime!.millisecondsSinceEpoch,
      'role': 'user'
    });
  }
}
