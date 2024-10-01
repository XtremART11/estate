import 'package:estate/app_layout.dart';
import 'package:estate/auth/register_screen.dart';
import 'package:estate/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: AppLayout(
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
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const Gap(10),
              FormBuilderTextField(
                name: '',
                decoration: const InputDecoration(labelText: "Mot de passe"),
              ),
              const Gap(20),
              ElevatedButton(onPressed: () {}, child: const Text("Se connecter")),
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
    );
  }
}
