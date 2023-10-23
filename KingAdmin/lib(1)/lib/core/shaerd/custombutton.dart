import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textbutton;
  final Function() onPressed;
  Color color;
  CustomButton(
      {super.key,
      required this.textbutton,
      required this.onPressed,
      this.color = AppColors.primaryColor});
  @override
  Widget build(Object context) {
    return MaterialButton(
      height: 50,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: color,
      textColor:
          color.value != Colors.black.value ? Colors.black : Colors.white,
      onPressed: onPressed,
      child: Text(
        textbutton,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
