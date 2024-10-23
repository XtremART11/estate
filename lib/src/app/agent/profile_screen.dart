import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/auth/auth_controller.dart';
import 'package:estate/src/app/auth/screens/login_screen.dart';
import 'package:estate/src/core/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

import '../../core/default_app_spacing.dart';
import '../estate/estate_repository.dart';
import '../main_screen.dart';
import 'agent_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final estateRepo = EstateRepository();
    final ref = context.ref;
    final authState = context.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Compte'),
      ),
      body: AppDefaultSpacing(
        child: FirebaseAuth.instance.currentUser == null
            ? Center(
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
                      'Il semble que vous n\'êtes pas connecté. Veuillez vous connecter pour accéder à votre espace',
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
              )
            : authState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(children: [
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: AgentRepository().getAgent(FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, snapshot) {
                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  child: Image.asset(
                                    "assets/images/pic.jpg",
                                    fit: BoxFit.cover,
                                    width: screenW(context) * 0.22,
                                  ),
                                ),
                                Gap(10),
                                snapshot.data?.data()?['name'] == null
                                    ? const Text('')
                                    : Text(snapshot.data!.data()?['name'], style: textTheme(context).titleMedium),
                                snapshot.data?.data()?['email'] == null
                                    ? const Text('')
                                    : Text(snapshot.data!.data()?['email'],
                                        style: TextStyle(color: Colors.black.withOpacity(0.5))),
                              ],
                            );
                          }),
                      Gap(20),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow.shade800,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
                              minimumSize: Size(screenW(context) * 0.1, 35)),
                          child: Text(
                            'Vérifier mon compte',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Gap(30),
                      Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 0,
                        child: ListTile(
                          leading: const Icon(Icons.privacy_tip_rounded),
                          title: const Text('Devenir agent immobiler'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 0,
                        child: ListTile(
                          leading: const Icon(Icons.history_rounded),
                          title: const Text('Historique d\'achat'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 0,
                        child: ListTile(
                          leading: const Icon(Icons.help_center_rounded),
                          title: const Text('Aide & Support'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 0,
                        child: ListTile(
                          leading: const Icon(Icons.settings_rounded),
                          title: const Text('Paramètres'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 0,
                        child: ListTile(
                          leading: const Icon(Icons.group_add_rounded),
                          title: const Text('Inviter un ami'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 0,
                        child: ListTile(
                          leading: const Icon(Icons.logout_rounded),
                          selected: true,
                          selectedColor: Colors.red,
                          title: const Text('Se déconnecter'),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Se déconnecter ?"),
                                  content: Text("Souhaitez-vous réellement vous déconnecter ?",
                                      style: textTheme(context).bodyLarge),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        ref.notifier(authControllerProvider).logout(
                                              onSuccess: () => navigateToReplace(context, const MainScreen()),
                                            );
                                        showToast(context, "Vous avez bien été déconnecté !");
                                      },
                                      child: Text(
                                        "Se deconnecter",
                                        style: textTheme(context).bodyLarge?.copyWith(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Annuler", style: textTheme(context).bodyLarge),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ]),
                  ),
      ),
    );
  }
}
