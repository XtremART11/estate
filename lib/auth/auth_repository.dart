import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/log.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  signupAgent({
    required String email,
    required String password,
  }) async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    logInfo(user);
  }

  completeProfile({
    required String uid,
    required String name,
    required String role,
    required String phone,
    required String email,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'phone': phone,
        'role': role,
      });
    } catch (e) {
      logErr(e);
    }
  }
}
