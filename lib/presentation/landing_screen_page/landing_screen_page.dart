import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nurmukhammed_s_application4/widgets/app_bar/custom_app_bar.dart';
import 'package:nurmukhammed_s_application4/widgets/app_bar/appbar_leading_image.dart';
import 'package:nurmukhammed_s_application4/widgets/app_bar/appbar_image.dart';
import 'package:nurmukhammed_s_application4/widgets/app_bar/appbar_title.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';

import '../game_vertical_screen/gamePage.dart';

class LandingScreenPage extends StatelessWidget {
  const LandingScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth:
            69.h, // Adjust if necessary to fit the AppBar aesthetically
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 30.h, // Adjust the size as needed
                height: 30.h, // Adjust the size as needed
                margin: EdgeInsets.only(
                    right: 0.h,
                    top: 10.h), // Adds space between the image and the text
                child: CustomImageView(
                  imagePath: ImageConstant.imgEllipse4,
                ),
              ),
              AppbarTitle(
                text: "Username",
                margin: EdgeInsets.fromLTRB(5.h, 10.v, 25.h, 0.v),
                style: TextStyle(fontSize: 40),
              ),
            ],
          ),
        ],
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
                // N
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TogyzQumalaqGame()));
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
