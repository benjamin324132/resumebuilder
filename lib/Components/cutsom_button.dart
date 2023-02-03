import 'package:flutter/material.dart';
import 'package:resumebuilder/Utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPress,
    required this.text,
  }) : super(key: key);
  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        minimumSize: const Size(double.infinity, 45),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      onPressed: onPress,
      child: Text(text),
    );
  }
}