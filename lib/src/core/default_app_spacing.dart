import 'package:flutter/material.dart';

class AppDefaultSpacing extends StatelessWidget {
  final Widget child;
  const AppDefaultSpacing({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: child,
        ),
      ),
    );
  }
}