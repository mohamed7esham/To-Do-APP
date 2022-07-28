import 'package:flutter/material.dart';

class ReusableLabelText extends StatelessWidget {

  final String label;
  final double txtSize;
  const ReusableLabelText({super.key, required this.label,  this.txtSize = 16.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style:  TextStyle(
        fontSize: txtSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}