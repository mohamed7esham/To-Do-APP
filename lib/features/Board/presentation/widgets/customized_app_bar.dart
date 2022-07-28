import 'package:flutter/material.dart';

class CustomizedTabBar extends StatelessWidget implements 
PreferredSizeWidget {
  const CustomizedTabBar({super.key});

    @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1.2,
          color: const Color(0xFFf1f1f1),
        ),
        const TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              indicatorWeight: 3.4,
              unselectedLabelColor: Color(0xFFbcbcbc),
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Completed'),
                Tab(text: 'Uncompleted'),
                Tab(text: 'Favorite'),
              ],
            ),
      ],
    );
  }
  
}