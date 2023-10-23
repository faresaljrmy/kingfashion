import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final String textbutton;
  final void Function() onPressed;

  const CustomButtonAuth(
      {super.key, required this.textbutton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
        onPressed: onPressed,
        color: AppColors.primaryColor,
        textColor: Colors.white,
        child: Text(
          textbutton,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
