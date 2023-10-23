// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButtonHomeAdmin extends StatelessWidget {
  Function()? onTap;
  String? title;
  String? details;
  Color? color;
  CustomButtonHomeAdmin(
      {super.key, this.onTap, this.title, this.details, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(8),
          // padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Text(
                title ?? "Null",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                details ?? "Null",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
