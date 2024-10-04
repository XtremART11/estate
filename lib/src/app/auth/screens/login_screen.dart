import 'package:estate/src/app/auth/screens/register_screen.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

import '../../../core/default_app_spacing.dart';
import '../../agent/home_screen.dart';
import '../auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ref = context.ref;
    final authState = context.watch(authControllerProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: AppDefaultSpacing(
        child: authState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: FormBuilder(
                    child: Column(
                      children: [
                        Text(
                          'Se connecter',
                          style: textTheme.headlineMedium,
                        ),
                        const Gap(20),
                        FormBuilderTextField(
                          name: '',
                          controller: emailController,
                          decoration: const InputDecoration(labelText: "Email"),
                          validator: FormBuilderValidators.email(),
                        ),
                        const Gap(10),
                        FormBuilderTextField(
                          controller: passwordController,
                          name: '',
                          decoration: const InputDecoration(labelText: "Mot de passe"),
                        ),
                        const Gap(20),
                        ElevatedButton(
                            onPressed: () {
                              ref.notifier(authControllerProvider).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    onSuccess: () {
                                      showToast(context, 'Bienvenue');
                                      navigateToReplace(context, const HomeScreen());
                                    },
                                  );
                            },
                            child: const Text("Se connecter")),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Vous n\'avez pas de compte ?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, const RegisterScreen());
                                },
                                child: const Text("S'inscrire")),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
