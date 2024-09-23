import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'merchant/merchant_home_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('currentUserInfo');
    final userRole = box.get('userRole');
    return userRole == 'client' ? const Placeholder() : const MerchantHomeScreen();
  }
}