import 'package:flutter/material.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';
import 'package:nurmukhammed_s_application4/presentation/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a 3-second delay before transitioning to the next page
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRoutes.loginScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: SizeUtils.width,
        height: SizeUtils.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.35, 0.54),
            end: Alignment(0.43, 1.42),
            colors: [
              appTheme.red400,
              appTheme.gray900,
            ],
          ),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 64),
              _buildOne(context),
              Spacer(flex: 35),
              CustomImageView(
                imagePath: ImageConstant.imgGroup7208,
                height: 302.v,
                width: 430.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildOne(BuildContext context) {
    return Container(
      height: 200.v,
      width: 393.h,
      margin: EdgeInsets.only(left: 11.h),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            margin: EdgeInsets.only(left: 40.h),
            imagePath: ImageConstant.img61795511Traced,
            height: 200.v,
            width: 170.h,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: AppDecoration.outlineBlack,
              child: Text(
                "TOGYZQUMALAQ",
                style: theme.textTheme.displaySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
