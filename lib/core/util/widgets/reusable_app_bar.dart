import 'package:flutter/material.dart';

class SimpleReusableAppBar extends StatelessWidget implements 
 PreferredSizeWidget {

  final String title;
  final Color backgroundColor;
  final Color tilteColor;

  const SimpleReusableAppBar({super.key, required this.title,
    this.backgroundColor = Colors.white,  this.tilteColor = Colors.black});

    @override
    Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
          shape: const Border(bottom: BorderSide(color: Color(0xFFf1f1f1))),
          backgroundColor: backgroundColor,
          foregroundColor: tilteColor,
          elevation: 0,
          title:  Text(title),
          leading: IconButton(padding: const EdgeInsets.only(left: 16),
            icon: const Icon(Icons.arrow_back_ios_new,size: 12,),
            onPressed: () => Navigator.pop(context),
          ),
    );
  }
  
}