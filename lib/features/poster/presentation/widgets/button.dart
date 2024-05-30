import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  final Color color;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPress,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13))),
      child: Text(label, style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18)),
    );
  }
}