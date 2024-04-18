import 'package:flutter/material.dart';
import 'package:nurmukhammed_s_application4/presentation/chat_screen/chat_page.dart';
import 'package:nurmukhammed_s_application4/presentation/discover_screen/discover_page.dart';
import 'package:nurmukhammed_s_application4/presentation/landing_screen_page/landing_screen_page.dart';
import 'package:nurmukhammed_s_application4/presentation/profile_screen/profile_page.dart';
import 'package:nurmukhammed_s_application4/presentation/statistics_screen/statistics_page.dart';
import 'package:nurmukhammed_s_application4/widgets/custom_bottom_bar.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';

// ignore_for_file: must_be_immutable
class LandingScreenContainerScreen extends StatefulWidget {
  @override
  _LandingScreenContainerScreenState createState() =>
      _LandingScreenContainerScreenState();
}

class _LandingScreenContainerScreenState
    extends State<LandingScreenContainerScreen> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    DiscoverPage(),
    ChatPage(),
    LandingScreenPage(),
    StatisticsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onChanged: _onItemTapped,
      ),
    );
  }
}
