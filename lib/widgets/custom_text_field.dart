import 'package:flutter/material.dart';
import 'package:shartflix/shared/icon_color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? iconAsset;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.iconAsset,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_focusNode.hasFocus) {
      final currentState = _formFieldKey.currentState;
      currentState?.validate();
    }
  }

  final GlobalKey<FormFieldState> _formFieldKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formFieldKey,
      controller: widget.controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: widget.iconAsset == null
            ? SizedBox()
            : themedIcon(context, widget.iconAsset!),
      ),
      validator: widget.validator,
    );
  }
}
