import 'dart:async';

import 'package:estate/log.dart';
import 'package:estate/property/property_repository.dart';
import 'package:flutter/material.dart';
import 'package:refena_flutter/refena_flutter.dart';

final propertyControllerProvider = AsyncNotifierProvider<PropertyNotifier, void>((ref) => PropertyNotifier());

class PropertyNotifier extends AsyncNotifier<void> {
  @override
  Future<void> init() async {
    await Future.value(null);
  }

  addProperty({
    required String city,
    required String price,
    required String description,
    required List imageUrls,
    required String location,
    required String quarter,
    VoidCallback? onSuccess,
  }) async {
    final property = PropertyRepository();
    try {
      state = const AsyncValue.loading();
      await property.addProperty({
        'city': city,
        'price': price,
        'description': description,
        'quarter': quarter,
        'imageUrls': imageUrls,
        'location': location,
      });
      state = const AsyncValue.data(null);
      onSuccess?.call();
    } catch (e) {
      logErr(e);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
