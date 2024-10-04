import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/auth/auth_controller.dart';
import 'package:estate/src/app/estate/screens/estate_add_screen.dart';
import 'package:estate/src/core/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:refena_flutter/refena_flutter.dart';

import '../../core/default_app_spacing.dart';
import '../estate/estate_repository.dart';
import '../estate/screens/estate_detail_screen.dart';
import '../estate/widgets/estate_card.dart';
import '../no_account_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final property = PropertyRepository();
    final ref = context.ref;
    final authState = context.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Espace'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Se déconnecter ?"),
                        content: const Text("Souhaitez-vous réellement vous déconnecter ?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              ref.notifier(authControllerProvider).logout(
                                    onSuccess: () => navigateToReplace(context, const NoAccountScreen()),
                                  );
                              showToast(context, "Vous avez bien été déconnecté !");
                            },
                            child: const Text("Se deconnecter"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Annuler"),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            navigateTo(context, const EstateAddScreen());
          }),
      body: authState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseAuth.instance.currentUser != null
                  ? property.getEstates(FirebaseAuth.instance.currentUser!.uid)
                  : property.getEstates(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return AppDefaultSpacing(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final estate = snapshot.data!.docs[index];
                      return EstateCard(
                        estate: estate,
                        onTap: () => navigateTo(
                            context,
                            EstateDetailScreen(
                              estate: estate,
                            )),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
