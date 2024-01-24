import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputCustom extends StatelessWidget {
  final String placeholder;
  final bool hideText;
  void Function(String) onChanged;

  InputCustom({
    super.key,
    required this.placeholder,
    required this.hideText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: (value) {
          onChanged(value);
        },
        obscureText: hideText,
        decoration: InputDecoration(
          hintText: placeholder,
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
        ),
      ),
    );
  }
}
