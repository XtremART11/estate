import 'package:estate/property/add_property_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: const [
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: pageIndex,
          onDestinationSelected: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.verified_user), label: 'label'),
            NavigationDestination(icon: Icon(Icons.verified_user), label: 'label')
          ]),
    );
  }
}
