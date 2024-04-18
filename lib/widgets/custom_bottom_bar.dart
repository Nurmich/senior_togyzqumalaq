import 'package:flutter/material.dart';

enum BottomBarEnum { Home, Discover, Chat, Profile, Statistics }

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  CustomBottomBar({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onChanged,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Statistics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFFC57941),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white24,
      showUnselectedLabels: true,
      showSelectedLabels: true,
    );
  }
}
