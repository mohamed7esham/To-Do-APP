import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  
  final String text;
  final Color textColor;
  final double height;
  final double width;
  final double radius;
  final Color buttonColor;
  final VoidCallback onClick;

  const MainButton({ Key? key, required this.text, this.textColor = Colors.white,
   required this.height, this.width = double.infinity, required this.radius, 
   required this.buttonColor, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: height,
      onPressed: onClick,
      color:  buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child:  Center(child: Text(text, style: const TextStyle(fontSize: 16,color: Colors.white),)),
    );
  }
}