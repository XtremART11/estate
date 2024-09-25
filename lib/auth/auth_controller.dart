import 'dart:async';

import 'package:estate/auth/auth_repository.dart';
import 'package:refena_flutter/refena_flutter.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, void>((ref) => AuthController());

class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> init() async {
    return await null;
  }

  registerAgent({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    final authRepo = AuthRepository();
    try {
      state = const AsyncValue.loading();
      await authRepo.signupAgent(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
