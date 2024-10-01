import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final VoidCallback onPressed;

  QuizButton({required this.buttonColor, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
