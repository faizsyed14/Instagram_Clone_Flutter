import 'package:flutter/material.dart';

class Followbutton extends StatelessWidget {
  const Followbutton(
      {super.key,
      this.function,
      required this.backgrouncolor,
      required this.text,
      required this.bordercolor,
      required this.textcolor});
  final Function()? function;
  final Color backgrouncolor;
  final String text;
  final Color textcolor;
  final Color bordercolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: TextButton(
          onPressed: function,
          child: Container(
            width: 250,
            height: 27,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                  color: bordercolor,
                ),
                color: backgrouncolor,
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              text,
              style: TextStyle(
                color: textcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
