import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelString;
  final IconData iconData;
  final bool isObsure;
  final VoidCallback? onTap;

  const TextInputWidget({
    Key? key,
    required this.textEditingController,
    required this.labelString,
    required this.iconData,
    required this.isObsure,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          controller: textEditingController,
          obscureText: isObsure,
          decoration: InputDecoration(
            labelText: labelString,
            prefixIcon: Icon(iconData),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $labelString';
            }
            return null;
          },
        ),
      ),
    );
  }
}