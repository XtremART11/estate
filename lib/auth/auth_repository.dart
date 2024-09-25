import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/log.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  registerAgent({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await completeProfile(uid: res.user!.uid, name: name, phone: phone, email: email);
      logInfo(res);
    } catch (e) {
      logErr(e);
    }
  }

  completeProfile({
    required String uid,
    required String name,
    required String phone,
    required String email,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('agents').doc(uid).set({
        'email': email,
        'phone': phone,
        'name': name,
      });
    } catch (e) {
      logErr(e);
    }
  }
}
