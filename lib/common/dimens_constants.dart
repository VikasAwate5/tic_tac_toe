class DimensConstants {
  DimensConstants._();

  // Generic reusable tokens
  static const Duration duration200 = Duration(milliseconds: 200);
  static const Duration duration250 = Duration(milliseconds: 250);
  static const Duration duration800 = Duration(milliseconds: 800);

  static const double value0_5 = 0.5;
  static const double value1 = 1.0;
  static const double value1_5 = 1.5;
  static const double value2 = 2.0;
  static const double value5 = 5.0;
  static const double value6 = 6.0;
  static const double value8 = 8.0;
  static const double value10 = 10.0;
  static const double value12 = 12.0;
  static const double value14 = 14.0;
  static const double value16 = 16.0;
  static const double value20 = 20.0;
  static const double value24 = 24.0;
  static const double value28 = 28.0;
  static const double value30 = 30.0;
  static const double value36 = 36.0;
  static const double value44 = 44.0;
  static const double value56 = 56.0;

  static const double factor0_045 = 0.045;
  static const double factor0_08 = 0.08;
  static const double factor1_08 = 1.08;

  static const int count3 = 3;
  static const int count9 = 9;

  // Semantic aliases used by UI
  static const Duration pulseAnimationDuration = duration800;
  static const double pulseScaleStart = value1;
  static const double pulseScaleEnd = factor1_08;

  static const double titleVerticalPadding = value16;
  static const double titleFontFactor = factor0_08;
  static const double titleLetterSpacing = value2;
  static const double titleShadowBlur = value12;
  static const double titleShadowOffsetY = value2;

  static const double scoreHorizontalPadding = value24;
  static const double scoreCardGap = value16;
  static const double scoreCardVerticalPadding = value14;
  static const double scoreCardHorizontalPadding = value12;
  static const double scoreCardRadius = value16;
  static const double scoreCardBorderWidth = value1_5;
  static const double scoreLabelFontSize = value14;
  static const double scoreLabelLetterSpacing = value0_5;
  static const double scoreValueTopSpacing = value6;
  static const double scoreValueFontSize = value36;

  static const double turnIndicatorHorizontalPadding = value28;
  static const double turnIndicatorVerticalPadding = value10;
  static const double turnIndicatorRadius = value30;
  static const double turnIndicatorBorderWidth = value1_5;
  static const double turnIndicatorFontFactor = factor0_045;
  static const double turnIndicatorLetterSpacing = value1;

  static const double sectionSpacingSmall = value20;
  static const double sectionSpacingMedium = value24;

  static const double boardHorizontalPadding = value20;
  static const double boardAspectRatio = value1;
  static const double boardRadius = value20;
  static const double boardGlowBlur = value30;
  static const double boardGlowSpread = value5;
  static const int boardCellCount = count9;
  static const int boardCrossAxisCount = count3;
  static const double boardGridSpacing = value10;

  static const double actionButtonFontSize = value16;
  static const double actionButtonLetterSpacing = value1;
  static const double actionButtonVerticalPadding = value16;
  static const double actionButtonRadius = value16;
  static const double actionButtonElevation = value8;

  static const Duration cellAnimationDuration = duration200;
  static const double cellRadius = value16;
  static const double cellBorderWidth = value1_5;
  static const double winningCellGlowBlur = value12;

  static const Duration markerAnimationDuration = duration250;
  static const double markerFontSize = value44;
  static const double markerShadowBlur = value10;

  static const double dialogPadding = value28;
  static const double dialogRadius = value24;
  static const double dialogBorderWidth = value1_5;
  static const double dialogShadowBlur = value24;
  static const double dialogEmojiFontSize = value56;
  static const double dialogTopSpacing = value12;
  static const double dialogBodySpacing = value8;
  static const double dialogActionTopSpacing = value24;
  static const double dialogTitleFontSize = value28;
  static const double dialogBodyFontSize = value16;
  static const double dialogButtonVerticalPadding = value14;
  static const double dialogButtonRadius = value14;
}
