import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/create_account_screen/create_account_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/landing_screen_container_screen/landing_screen_container_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/game_vertical_screen/gamePage.dart';
import '../presentation/discover_screen/discover_page.dart';
import '../presentation/chat_screen/chat_page.dart';
import '../presentation/profile_screen/profile_page.dart';
import '../presentation/statistics_screen/statistics_page.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String createAccountScreen = '/create_account_screen';

  static const String loginScreen = '/login_screen';

  static const String landingScreenContainerScreen =
      '/landing_screen_container_screen';

  static const String landingScreenPage = '/landing_screen_page';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String gameVerticalScreen = '/gamePage';

  static const String discoverPage = '/discover_page';

  static const String chatPage = '/chat_page';

  static const String profilePage = '/profile_page';

  static const String statisticsPage = '/statistics_page';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    gameVerticalScreen: (context) => TogyzQumalaqGame(difficulty: 1),
    createAccountScreen: (context) => CreateAccountScreen(),
    loginScreen: (context) => LoginScreen(),
    landingScreenContainerScreen: (context) => LandingScreenContainerScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    discoverPage: (context) => DiscoverPage(),
    chatPage: (context) => ChatPage(),
    profilePage: (context) => ProfilePage(),
    statisticsPage: (context) => StatisticsPage(),
  };
}
