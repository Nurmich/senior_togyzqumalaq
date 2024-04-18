import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nurmukhammed_s_application4/widgets/app_bar/custom_app_bar.dart';
import 'package:nurmukhammed_s_application4/widgets/app_bar/appbar_leading_image.dart';
import 'package:nurmukhammed_s_application4/widgets/app_bar/appbar_image.dart';
import 'package:nurmukhammed_s_application4/widgets/app_bar/appbar_title.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';

import '../game_vertical_screen/gamePage.dart';

class DifficultyButton extends StatelessWidget {
  final String title;
  final Color color;

  const DifficultyButton({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);
  int getDifficultyLevel() {
    switch (title) {
      case 'Easy':
        return 1;
      case 'Medium':
        return 2;
      case 'Hard':
        return 3;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 70.0,
      margin: EdgeInsets.only(left: 65, right: 65, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.transparent, width: 0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Container(
            width: 20.0,
            height: 20.0,
            decoration: ShapeDecoration(
              shape: CircleBorder(side: BorderSide(color: color, width: 1)),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                int difficulty = getDifficultyLevel();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TogyzQumalaqGame(difficulty: difficulty),
                  ),
                );
              },
              focusColor: color,
              hoverColor: color,
              icon: Container(),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 8), // Space between
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

class LandingScreenPage extends StatelessWidget {
  const LandingScreenPage({Key? key}) : super(key: key);
  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color(0xFFC57941).withOpacity(0.70),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(buildContext).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Choose difficulty:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..color = Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 28),
                    DifficultyButton(title: 'Easy', color: Colors.green),
                    DifficultyButton(title: 'Medium', color: Colors.yellow),
                    DifficultyButton(title: 'Hard', color: Colors.red),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFC57941),
        title: Text("Username"),
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 50.h,
          top: 126.v,
          right: 50.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offline Section
            GestureDetector(
              onTap: () {
                showCustomDialog(context);
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.circleBorder12,
                ),
                child: Container(
                  height: 169.v,
                  width: 315.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.h,
                    vertical: 11.v,
                  ),
                  decoration: AppDecoration.gradientOrangeAToRed.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder12,
                  ),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgArrowLeft,
                        height: 9.v,
                        width: 14.h,
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(
                          left: 22.h,
                          bottom: 12.v,
                        ),
                      ),
                      Positioned(
                        left: 22.h,
                        top: 18.v,
                        child: Text(
                          "Offline",
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Positioned(
                        top: 45.v,
                        left: 22.h,
                        child: SizedBox(
                          width: 150.h,
                          child: Text(
                            "Dive right into the offline mode and enjoy exciting gameplay against AI opponent",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.bodySmallWhiteA700,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 22.v,
                        left: 170.h,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgHand1,
                          height: 100.v,
                          width: 150.h,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Spacer between Offline and Online
            SizedBox(height: 10.v),

            // Online Section
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.circleBorder12,
              ),
              child: Container(
                height: 169.v,
                width: 315.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 2.h,
                  vertical: 11.v,
                ),
                decoration: AppDecoration.gradientOrangeAToRed.copyWith(
                  borderRadius: BorderRadiusStyle.circleBorder12,
                ),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgArrowLeft,
                      height: 9.v,
                      width: 14.h,
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(
                        left: 22.h,
                        bottom: 12.v,
                      ),
                    ),
                    Positioned(
                      left: 22.h,
                      top: 18.v,
                      child: Text(
                        "Online",
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    Positioned(
                      top: 45.v,
                      left: 22.h,
                      child: SizedBox(
                        width: 150.h,
                        child: Text(
                          "Easily schedule event/games then find like minded players for battle. You up for it?",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodySmallWhiteA700,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2.v,
                      left: 170.h,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgGlobe1,
                        height: 139.adaptSize,
                        width: 139.adaptSize,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 5.v),
          ],
        ),
      ),
    );
  }
}
