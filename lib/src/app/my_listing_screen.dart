import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/auth/auth_controller.dart';
import 'package:estate/src/app/auth/screens/login_screen.dart';
import 'package:estate/src/app/estate/screens/estate_list_screen.dart';
import 'package:estate/src/core/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

import '../core/default_app_spacing.dart';
import 'estate/estate_repository.dart';
import 'estate/screens/estate_add_screen.dart';

class MyListingScreen extends StatelessWidget {
  const MyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final estateRepo = EstateRepository();
    final ref = context.ref;
    final authState = context.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Listing'),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            FirebaseAuth.instance.currentUser == null
                ? showToast(context, 'Veuillez d\'abord vous connecter !')
                : navigateTo(context, const EstateAddScreen());
          }),
      body: FirebaseAuth.instance.currentUser == null
          ? Center(
              child: AppDefaultSpacing(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 80,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    const Gap(20),
                    Text(
                      'Il semble que vous n\'êtes pas connecté. Veuillez vous connecter pour accéder à vos listings.',
                      textAlign: TextAlign.center,
                      style: textTheme(context).titleLarge?.copyWith(color: Colors.black.withOpacity(0.5)),
                    ),
                    const Gap(30),
                    ElevatedButton(
                        onPressed: () {
                          navigateTo(context, const LoginScreen());
                        },
                        child: const Text('Se connecter'))
                  ],
                ),
              ),
            )
          : authState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseAuth.instance.currentUser != null
                      ? estateRepo.getEstates(FirebaseAuth.instance.currentUser!.uid)
                      : estateRepo.getEstates(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return AppDefaultSpacing(child: EstateListScreen(snapshot: snapshot));
                  },
                ),
    );
  }
}
