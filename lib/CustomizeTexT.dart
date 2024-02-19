import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textfund extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String> validator;
  final bool? obscureText;
 // final bool greenIcon;
  const Textfund({
    super.key,
    this.hintText,
    required this.controller,
    required this.validator,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText!,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          fillColor: Color(0xFFFFFF),
          filled: true,
          border: UnderlineInputBorder()),
    );
  }
}
