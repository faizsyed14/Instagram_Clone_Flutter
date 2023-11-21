// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextFieldinput extends StatelessWidget {
  const TextFieldinput(
      {required this.hintText,
      this.isPass = false,
      required this.textEditingController,
      required this.textInputType,
      super.key});
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
