import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonButomAppBar extends StatelessWidget {
  final String? textbutton;
  final IconData iconbutton;
  final void Function()? onPressed;
  final bool? active;
  const CustomButtonButomAppBar(
      {super.key,
      this.textbutton,
      required this.iconbutton,
      this.onPressed,
      this.active});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconbutton,
              color: active == true ? AppColors.primaryColor : AppColors.grey2),
          Text(
            textbutton!,
            style: TextStyle(
                color:
                    active == true ? AppColors.primaryColor : AppColors.grey2,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
