
import 'package:flutter/material.dart';

class CustomTextTitleAuth extends StatelessWidget{
  final String text;
  const CustomTextTitleAuth({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 25),
    child:Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayMedium,

    ) ,
  );
  }


}