import 'package:flutter/material.dart';
import 'package:shartflix/shared/icon_color.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? iconAsset;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.iconAsset,
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
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: themedIcon(context, widget.iconAsset!),
        ),
        suffixIcon: IconButton(
          icon: themedIcon(
            context,
            _obscureText
                ? 'assets/icon/visibility_on.png'
                : 'assets/icon/visibility_off.png',
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
      ),
    );
  }
}
