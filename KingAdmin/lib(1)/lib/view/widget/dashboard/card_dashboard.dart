import 'package:flutter/material.dart';

class CardDashboard extends StatelessWidget {
  final void Function()? onTap;
  final String? url;
  final String? title;

  const CardDashboard(
      {super.key, required this.onTap, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 2,
                child: Image.asset(
                  url!,
                  width: 80,
                )),
            // SizedBox(height: 10,),
            Expanded(
                child: Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ))
          ],
        ),
      ),
    );
  }
}
