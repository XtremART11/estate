import 'package:estate/src/app/auth/screens/register_screen.dart';
import 'package:estate/src/app/main_screen.dart';
import 'package:estate/src/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:refena_flutter/refena_flutter.dart';

import '../../../core/default_app_spacing.dart';
import '../auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
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
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Se connecter',
                          style: textTheme.headlineMedium,
                        ),
                        const Text(
                          'Connectez-vous à votre compte afin de pouvoir ajouter de nouveaux immeubles',
                        ),
                        const Gap(20),
                        FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            name: 'email',
                            controller: emailController,
                            decoration: const InputDecoration(labelText: "Email"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.email(),
                              FormBuilderValidators.required(),
                            ])),
                        const Gap(10),
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          name: 'password',
                          obscureText: obscureText,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () => setState(() {
                                  obscureText = !obscureText;
                                }),
                                child: obscureText
                                    ? const Icon(Icons.visibility_rounded)
                                    : const Icon(Icons.visibility_off_rounded),
                              ),
                              labelText: "Mot de passe"),
                          validator: FormBuilderValidators.password(
                            minLength: 6,
                            minLowercaseCount: 0,
                            minNumberCount: 0,
                            minUppercaseCount: 0,
                            minSpecialCharCount: 0,
                          ),
                        ),
                        const Gap(20),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref.notifier(authControllerProvider).login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      onSuccess: () {
                                        showToast(context, 'Bienvenue');
                                        navigateToReplace(context, const MainScreen());
                                      },
                                    );
                              }
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
