import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/property/add_property_screen.dart';
import 'package:estate/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'agent_main_screen.dart';
import 'default_app_spacing.dart';
import 'property/property_repository.dart';
import 'property_detail_screen.dart';

class AgentProfileScreen extends StatelessWidget {
  const AgentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final property = PropertyRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Espace'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            navigateTo(context, const AddPropertyScreen());
          }),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseAuth.instance.currentUser != null ? property.getProperties(FirebaseAuth.instance.currentUser!.uid):property.getProperties(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return DefaultAppSpacing(
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
                      PropertyDetailScreen(
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
