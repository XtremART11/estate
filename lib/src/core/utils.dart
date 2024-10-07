import 'package:flutter/material.dart';
TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
screenH(BuildContext context) => MediaQuery.of(context).size.height;
screenW(BuildContext context) => MediaQuery.of(context).size.width;

navigateTo(BuildContext context, Widget page) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );

navigateToReplace(BuildContext context, Widget page) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );

showToast(BuildContext context, String message) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
