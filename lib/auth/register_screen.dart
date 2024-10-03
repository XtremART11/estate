import 'package:estate/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

import '../agent_main_screen.dart';
import '../app_layout.dart';
import '../utils.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
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
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Creer un compte',
                    style: textTheme.headlineMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        'Vous avez deja un compte ?',
                        style: textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => navigateTo(context, const LoginScreen()),
                        child: Text(
                          'Connectez-vous',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  FormBuilder(
                      child: Column(children: [
                    FormBuilderTextField(
                      controller: nameController,
                      name: 'name',
                      decoration: const InputDecoration(labelText: 'Nom'),
                    ),
                    const Gap(10),
                    FormBuilderTextField(
                      controller: phoneController,
                      name: 'phone',
                      decoration: const InputDecoration(labelText: 'Telephone'),
                    ),
                    const Gap(10),
                    FormBuilderTextField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'email',
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: FormBuilderValidators.email(),
                    ),
                    const Gap(10),
                    FormBuilderTextField(
                      controller: passwordController,
                      name: 'password',
                      decoration: const InputDecoration(labelText: 'Mot de passe'),
                    ),
                    const Gap(20),
                    ElevatedButton(
                        onPressed: () {
                          ref.notifier(authControllerProvider).registerAgent(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                onSuccess: () {
                                  showToast(context, 'Compte cree avec succes');
                                  navigateToReplace(context, const AgentMainScreen());
                                },
                              );
                        },
                        child: const Text('Creer mon compte')),
                    // const Text("S'inscrire en tant que Agent immobilier"),
                  ])),
                ],
              ),
      ),
    );
  }
}
