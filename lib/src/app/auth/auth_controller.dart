import 'dart:async';

import 'package:estate/src/app/auth/auth_repository.dart';
import 'package:estate/src/core/log.dart';
import 'package:flutter/material.dart';
import 'package:refena_flutter/refena_flutter.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, void>((ref) => AuthController());

class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> init() async {
    return await null;
  }

  logout({
    VoidCallback? onSuccess,
  }) async {
    final authRepo = AuthRepository();
    try {
      state = const AsyncValue.loading();
      await authRepo.logout();
      state = const AsyncValue.data(null);
      onSuccess?.call();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> login({
    required String email,
    required String password,
    VoidCallback? onSuccess,
  }) async {
    logInfo('Login: $email, $password');
    final authRepo = AuthRepository();
    try {
      state = const AsyncValue.loading();
      await authRepo.login(email, password);
      state = const AsyncValue.data(null);
      onSuccess?.call();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  registerAgent({
    required String name,
    required String phone,
    required String email,
    required String password,
    VoidCallback? onSuccess,
  }) async {
    final authRepo = AuthRepository();
    try {
      state = const AsyncValue.loading();
      await authRepo.registerAgent(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      state = const AsyncValue.data(null);
      onSuccess?.call();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
