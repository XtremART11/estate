import 'package:flutter/material.dart';

class DefaultAppSpacing extends StatelessWidget {
  final Widget child;
  const DefaultAppSpacing({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: child,
        ),
      ),
    );
  }
}
