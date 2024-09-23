import 'package:estate/auth/additional_info.dart';
import 'package:estate/bottom_navbar.dart';
import 'package:estate/log.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [EmailAuthProvider()],
            showPasswordVisibilityToggle: true,
            actions: [
              AuthStateChangeAction<SigningUp>((context, state) {
                logInfo(FirebaseAuth.instance.currentUser!.uid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdditionalInfos(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  ),
                );
              }),
              AuthStateChangeAction<SigningIn>((context, state) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              })
            ],
          );
        }

        return const BottomNavbar();
      },
    );
  }
}
