import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/common/widgets/buttons/custom_buttom.dart';
import 'package:social_app/common/widgets/text_fields/custom_text_field.dart';
import 'package:social_app/common/widgets/text_fields/custom_text_field_password.dart';

import '../utils/handle_login.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(label: 'Email', controller: _usernameController),
            PasswordTextField(
                label: 'Password', controller: _passwordController),
            CustomButton(
                text: 'Login',
                onPressed: () {
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  handleLogin(context, ref, username, password);
                })
          ],
        ),
      ),
    );
  }
}

