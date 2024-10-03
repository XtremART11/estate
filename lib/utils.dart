import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget page) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
    
navigateToReplace(BuildContext context, Widget page) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );

showToast(BuildContext context, String message) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
