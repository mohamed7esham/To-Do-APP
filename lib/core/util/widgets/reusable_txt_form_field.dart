import 'package:flutter/material.dart';

class ResuableTextFormField extends StatelessWidget {

  final String hintTextt;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? txtfield;
  const ResuableTextFormField({ Key? key, required this.hintTextt,
   this.obscureText =false, this.keyboardType, this.suffixIcon, this.txtfield }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: double.infinity,
        height: 45.0,
        child: TextFormField(
          controller: txtfield,
          keyboardType: TextInputType.text,
          decoration:InputDecoration(
            focusedBorder: UnderlineInputBorder(
             borderSide: const BorderSide(color: Colors.transparent),
             borderRadius:
              BorderRadius.circular(8.5)
            ),

            border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8.5),
            ),

            enabledBorder:  OutlineInputBorder(
              borderRadius:BorderRadius.circular(8.5),
               borderSide:const BorderSide(
               color: Colors.transparent,
              ),
            ),
            
            fillColor: Colors.grey[100], filled: true,
            contentPadding: const EdgeInsets.only(left: 16.0, top: 2),
            hintText: hintTextt,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xffc9c9c9),
            ),
          ),
          style: const TextStyle(color: Colors.grey),
        ),
      );
  }
}