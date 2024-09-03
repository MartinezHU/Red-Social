import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  const PasswordTextField({
    super.key,
    required this.label,
    this.obscureText = true,
    required this.controller,
  });

  @override
  PasswordTextFieldState createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  String? errorText;
  bool showPassword = false;

  bool _isValidPassword(String password) {
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: widget.controller,
        obscureText: !showPassword,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: widget.label,
            hintText: 'Introduce tu contraseña',
            border: const OutlineInputBorder(),
            errorText: errorText,
            suffixIcon: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            )),
        onChanged: (value) {
          setState(() {
            //Validar password en tiempo real
            if (_isValidPassword(value)) {
              errorText = null;
            } else {
              errorText = 'Contraseña no válida';
            }
          });
        },
      ),
    );
  }
}
