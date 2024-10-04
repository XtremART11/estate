import 'dart:async';

import 'package:estate/src/core/log.dart';
import 'package:estate/src/app/estate/estate_repository.dart';
import 'package:flutter/material.dart';
import 'package:refena_flutter/refena_flutter.dart';

final propertyControllerProvider = AsyncNotifierProvider<PropertyNotifier, void>((ref) => PropertyNotifier());

class PropertyNotifier extends AsyncNotifier<void> {
  @override
  Future<void> init() async {
    await Future.value(null);
  }

  addEstate({
    required String city,
    required String price,
    required String description,
    required List featuredImageLink,
    required List fileLinks,
    required Map<String,dynamic> location,
    required String quarter,
    required List<Map<String, dynamic>> coordinates,
    VoidCallback? onSuccess,
  }) async {
    final property = PropertyRepository();
    try {
      state = const AsyncValue.loading();
      await property.addEstate({
        'city': city,
        'price': price,
        'description': description,
        'quarter': quarter,
        'fileLinks': fileLinks,
        'featuredImageLink': featuredImageLink,
        'coordinates': coordinates,
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
