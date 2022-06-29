import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key? key, required this.icon, required this.text, this.second})
      : super(key: key);

  final Icon icon;
  final String text;
  final String? second;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: light, borderRadius: BorderRadius.circular(100)),
        child: icon,
      ),
      const SizedBox(
        height: 10,
      ),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "$text\n",
                style: TextStyle(
                    fontSize: 16, color: dark, fontWeight: FontWeight.bold)),
            TextSpan(
                text: second,
                style: TextStyle(
                    fontSize: 16, color: dark, fontWeight: FontWeight.bold)),
          ])),
    ]);
  }
}
