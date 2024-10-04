import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/core/log.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      logErr(e.toString());
    } catch (e) {
      logErr(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    logInfo('$email, $password');
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      // User logged in successfully
      logInfo('User logged in successfully: ${userCredential.user?.uid}');
      // Navigate to the home screen or other desired destination
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      if (e.code == 'user-not-found') {
        logErr('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logErr('Wrong password provided.');
      } else {
        logErr('Login failed: ${e.message}');
      }
      rethrow;
    }
  }

  registerAgent({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      logInfo('$email, $password, $name, $phone');
      final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await completeProfile(uid: res.user!.uid, name: name, phone: phone, email: email);
      logInfo(res);
    } catch (e) {
      logErr(e);
      rethrow;
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
