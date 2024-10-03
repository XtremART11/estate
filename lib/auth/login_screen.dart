import 'package:estate/app_layout.dart';
import 'package:estate/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

import '../agent_main_screen.dart';
import 'auth_controller.dart';

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
      body: AppLayout(
        child: authState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : FormBuilder(
                child: Column(
                  children: [
                    Text(
                      'Se connecter',
                      style: textTheme.headlineMedium,
                    ),
                    const Gap(20),
                    FormBuilderTextField(
                      name: '',
                      decoration: const InputDecoration(labelText: "Email"),
                      validator: FormBuilderValidators.email(),
                    ),
                    const Gap(10),
                    FormBuilderTextField(
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
                                  navigateToReplace(context, const AgentMainScreen());
                                },
                              );
                        },
                        child: const Text("Se connecter")),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Vous n\'avez pas de compte ?'),
                        TextButton(onPressed: () {}, child: const Text("S'inscrire")),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
