import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CurvedBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const CurvedBottomNavigationBar({
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Color(0xFFC57941),
      color: Colors.white,
      buttonBackgroundColor: Color.fromARGB(255, 229, 229, 229),
      height: 50,
      index: selectedIndex,
      items: <Widget>[
        Icon(Icons.explore, size: 30),
        Icon(Icons.chat, size: 30),
        Icon(Icons.home, size: 30),
        Icon(Icons.bar_chart, size: 30),
        Icon(Icons.account_circle, size: 30),
      ],
      onTap: onChanged,
    );
  }
}
