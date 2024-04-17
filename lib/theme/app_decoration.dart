import 'package:flutter/material.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red400,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA70001,
      );
       static BoxDecoration get fillWhiteA1 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.16),
      );

  // Gradient decorations
  static BoxDecoration get gradientOrangeAToRed => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.5, 0.5),
          end: Alignment(0.5, 1.5),
          colors: [
            appTheme.orangeA100,
            appTheme.red300,
          ],
        ),
      );
  static BoxDecoration get gradientRedToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.35, 0.54),
          end: Alignment(0.43, 1.42),
          colors: [
            appTheme.red400,
            appTheme.gray900,
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration();
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder12 => BorderRadius.circular(
        12.h,
      );

  static BorderRadius get circleBorder33 => BorderRadius.circular(
        33.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
