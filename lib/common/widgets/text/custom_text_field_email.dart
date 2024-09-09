import 'package:flutter/material.dart';

class EmailTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;

  const EmailTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
  });

  @override
  EmailTextFieldState createState() => EmailTextFieldState();
}

class EmailTextFieldState extends State<EmailTextField> {
  String? errorText;

  bool _isValidEmail(String email) {
    String pattern =
        r'^[^@]+@[^@]+\.[^@]+$'; // Expresión regular para validar email
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: 'Introduce tu email',
          border: const OutlineInputBorder(),
          errorText: errorText,
        ),
        onChanged: (value) {
          setState(() {
            //Validar email en tiempo real
            if (_isValidEmail(value)) {
              errorText = null;
            } else {
              errorText = 'Email no válido';
            }
          });
        },
      ),
    );
  }
}
