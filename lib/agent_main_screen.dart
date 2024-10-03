import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/default_app_spacing.dart';
import 'package:estate/log.dart';
import 'package:estate/property/property_repository.dart';
import 'package:estate/utils.dart';
import 'package:flutter/material.dart';

import 'agent_profile_screen.dart';
import 'property_detail_screen.dart';

class AgentMainScreen extends StatelessWidget {
  const AgentMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final property = PropertyRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estate'),
        actions: [
          IconButton(
              onPressed: () {
                navigateTo(context, const AgentProfileScreen());
              },
              icon: const Icon(Icons.person_2_outlined))
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: property.getProperties(),
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

class EstateCard extends StatelessWidget {
  final VoidCallback? onTap;
  const EstateCard({super.key, required this.estate, required this.onTap});

  final QueryDocumentSnapshot<Map<String, dynamic>> estate;

  @override
  Widget build(BuildContext context) {
    logInfo(estate['imageUrls']);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (estate['imageUrls'] as List).isEmpty
                ? const SizedBox.shrink()
                : SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).width * 0.35,
                    child: Image.network(
                      estate['imageUrls'][0],
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(estate['city']),
                  Text('${estate['price']}/month'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Estate {
  final String name;
  final String imageUrl;
  final String description;
  final int price;

  Estate({required this.description, required this.name, required this.imageUrl, required this.price});
}
