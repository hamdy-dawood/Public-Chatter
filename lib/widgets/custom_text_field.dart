import 'package:chats_app/constants.dart';
import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.label,
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.autoValidate = AutovalidateMode.onUserInteraction,
    this.isLastInput = false,

  });

  final Function(String)? onChanged;
  final String label;
  final IconButton? prefixIcon, suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final AutovalidateMode autoValidate;
  final bool isLastInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autoValidate,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction:
          isLastInput ? TextInputAction.done : TextInputAction.next,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
