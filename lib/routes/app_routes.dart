import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/create_account_screen/create_account_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/landing_screen_container_screen/landing_screen_container_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/game_vertical_screen/gamePage.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String createAccountScreen = '/create_account_screen';

  static const String loginScreen = '/login_screen';

  static const String landingScreenContainerScreen =
      '/landing_screen_container_screen';

  static const String landingScreenPage = '/landing_screen_page';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String gameVerticalScreen = '/gamePage';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    gameVerticalScreen: (context) => TogyzQumalaqGame(),
    createAccountScreen: (context) => CreateAccountScreen(),
    loginScreen: (context) => LoginScreen(),
    landingScreenContainerScreen: (context) => LandingScreenContainerScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
