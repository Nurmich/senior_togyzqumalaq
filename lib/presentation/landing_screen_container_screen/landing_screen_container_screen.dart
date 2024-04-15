import 'package:nurmukhammed_s_application4/presentation/landing_screen_page/landing_screen_page.dart';
import 'package:nurmukhammed_s_application4/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';

// ignore_for_file: must_be_immutable
class LandingScreenContainerScreen extends StatelessWidget {
  LandingScreenContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Navigator(
            key: navigatorKey,
            initialRoute: AppRoutes.landingScreenPage,
            onGenerateRoute: (routeSetting) => PageRouteBuilder(
                pageBuilder: (ctx, ani, ani1) =>
                    getCurrentPage(routeSetting.name!),
                transitionDuration: Duration(seconds: 0))),
        bottomNavigationBar: _buildBottomBar(context));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.landingScreenPage;
      case BottomBarEnum.Discover:
        return "/";
      case BottomBarEnum.Chat:
        return "/";
      case BottomBarEnum.Profile:
        return "/";
      case BottomBarEnum.Statistics:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.landingScreenPage:
        return LandingScreenPage();
      default:
        return DefaultWidget();
    }
  }
}
