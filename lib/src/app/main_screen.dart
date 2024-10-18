import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/app/agent/profile_screen.dart';
import 'package:estate/src/app/explore_screen.dart';
import 'package:estate/src/app/map/map_screen.dart';
import 'package:estate/src/app/my_listing_screen.dart';
import 'package:flutter/material.dart';

import 'estate/estate_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final estateRepo = EstateRepository();

    return Scaffold(
      bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (value) => setState(() {
                currentIndex = value;
              }),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.map_rounded),
              label: 'Carte',
            ),
            NavigationDestination(
              icon: Icon(Icons.list_rounded),
              label: 'Mes Listings',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profil',
            ),
          ]),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: estateRepo.getEstates(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return IndexedStack(
            index: currentIndex,
            children: [
              const ExploreScreen(),
              MapScreen(
                estates: snapshot.data!.docs,
                initialLocation: const {},
              ),
              const MyListingScreen(),
              const ProfileScreen(),
            ],
          );
        },
      ),
    );
  }
}
// appBar: AppBar(
//         title: const Text('Estate'),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 navigateTo(context, const LoginScreen());
//               },
//               child: const Icon(Icons.login_outlined))
//         ],
//       ),