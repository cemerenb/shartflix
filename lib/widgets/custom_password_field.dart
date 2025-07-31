import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.icon = Icons.lock,
    this.validator,
    this.enabled = true,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Image.asset('assets/icon/password.png'),
        suffixIcon: IconButton(
          icon: Image.asset(
            _obscureText
                ? 'assets/icon/visibility_on.png'
                : 'assets/icon/visibility_off.png',
            scale: .8,
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
      ),
      validator: widget.validator,
    );
  }
}
