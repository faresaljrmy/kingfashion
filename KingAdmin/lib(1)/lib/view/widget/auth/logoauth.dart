import 'package:adminkingfashion/core/constant/imgaeasset.dart';
import 'package:flutter/material.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 70,
      backgroundColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ClipOval(child: Image.asset(AppImageAsset.logo)),
      ),
    );
  }
}
