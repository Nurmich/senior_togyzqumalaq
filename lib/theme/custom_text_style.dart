import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmallBlue400 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blue400,
      );
  static get bodySmallWhiteA700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 10.fSize,
      );
  static get bodySmallWhiteA70010 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 10.fSize,
      );
  static get bodySmallWhiteA700_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodySmallff030303 => theme.textTheme.bodySmall!.copyWith(
        color: Color(0XFF030303),
      );
  static get bodySmallff4ba7f3 => theme.textTheme.bodySmall!.copyWith(
        color: Color(0XFF4BA7F3),
      );
  // Label text style
  static get labelLargeRed400 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.red400,
      );
  static get labelLargeffc57941 => theme.textTheme.labelLarge!.copyWith(
        color: Color(0XFFC57941),
      );
  static get bodySmall12 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12.fSize,
      );
}

extension on TextStyle {
  TextStyle get cormorantGaramond {
    return copyWith(
      fontFamily: 'Cormorant Garamond',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
