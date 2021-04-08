import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  ///
  /// LIGHT THEME
  ///

  static final Color primary = Color(0xFF98CB69);
  static final Color primaryLight = Color(0xFFCDFF9E);
  static final Color primaryDark = Color(0xFF598036);

  static final Color secondary = Color(0xFF1979a9);
  static final Color secondaryLight = Color(0xFF1f97d3);
  static final Color secondaryDark = Color(0xFF146187);

  static final Color lightModeOffWhite = Color(0xFFd7ddd8);

  // Text legibility: https://material.io/design/color/text-legibility.html#text-backgrounds
  static final Color whiteHighEmphasis = Colors.white.withOpacity(.87);
  static final Color blackHighEmphasis = Colors.black.withOpacity(.87);
  static final Color whiteLowEmphasis = Colors.white.withOpacity(.60);
  static final Color blackLowEmphasis = Colors.black.withOpacity(.60);

  static final IconThemeData whiteIconThemeData = IconThemeData(color: whiteHighEmphasis);

  static final TextTheme whiteTextTheme = TextTheme(
    caption: TextStyle(color: whiteHighEmphasis),
    headline1: TextStyle(color: whiteHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline2: TextStyle(color: whiteHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline3: TextStyle(color: whiteHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline4: TextStyle(color: whiteHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline5: TextStyle(color: whiteHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline6: TextStyle(color: whiteHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    button: TextStyle(color: whiteHighEmphasis, fontFamily: "Source Sans Pro"),
    bodyText1: TextStyle(color: whiteHighEmphasis, fontFamily: "Source Serif Pro"),
    bodyText2: TextStyle(color: whiteHighEmphasis, fontFamily: "Source Sans Pro"),
  );

  static final IconThemeData blackIconThemeData = IconThemeData(color: blackHighEmphasis);

  static final TextTheme blackTextTheme = TextTheme(
    caption: TextStyle(
      color: blackHighEmphasis,
    ),
    headline1: TextStyle(color: blackHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline2: TextStyle(color: blackHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline3: TextStyle(color: blackHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline4: TextStyle(color: blackHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline5: TextStyle(color: blackHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline6: TextStyle(color: blackHighEmphasis, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    button: TextStyle(color: blackHighEmphasis, fontFamily: "Source Sans Pro"),
    bodyText1: TextStyle(color: blackHighEmphasis, fontFamily: "Source Serif Pro"),
    bodyText2: TextStyle(color: blackHighEmphasis, fontFamily: "Source Sans Pro"),
  );

  static final ColorScheme lightColorScheme = ColorScheme.light(
    primaryVariant: primaryLight,
    primary: primary,
    onPrimary: blackHighEmphasis,
    secondary: secondary,
    secondaryVariant: secondaryLight,
    onSecondary: whiteHighEmphasis,
    error: Colors.red,
    onError: whiteHighEmphasis,
    background: Colors.white,
    onBackground: blackHighEmphasis,
    surface: Colors.white,
    onSurface: blackHighEmphasis,
    brightness: Brightness.light,
  );

  static final ThemeData lightTheme = ThemeData(
    unselectedWidgetColor: blackHighEmphasis,
    appBarTheme: AppBarTheme(color: primary),
    brightness: Brightness.light,
    fontFamily: "Source Sans Pro",
    scaffoldBackgroundColor: lightModeOffWhite,
    dialogBackgroundColor: lightModeOffWhite,
    backgroundColor: Colors.white,
    colorScheme: lightColorScheme,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    iconTheme: IconThemeData(color: blackHighEmphasis),
    // Accents like button bar icons active, && logout icon
    accentColor: primary,
    // Theme for the switch color
    toggleableActiveColor: primary,
    primaryColor: primary,
    primaryColorLight: primaryLight,
    primaryColorDark: primaryDark,
    // primary: controls theme of widgets on primary swatches (eg. AppBar)
    primaryTextTheme: blackTextTheme,
    primaryIconTheme: blackIconThemeData,
    // just using this for a placeholder for dark theme of non-primary dark (relative to light/dark)
    secondaryHeaderColor: secondaryDark,
    accentTextTheme: whiteTextTheme,
    buttonColor: primary,
    buttonTheme: ButtonThemeData(
      buttonColor: primary,
      highlightColor: primaryLight,
    ),
    textTheme: blackTextTheme,
  );

  ///
  /// DARK THEME
  ///
  static final Color darkModeOffBlack = Color(0xFF212121);

  static final Color darkModeColor = Color(0xFF121212);

  static final ColorScheme darkColorScheme = ColorScheme.dark(
    primaryVariant: primaryDark,
    primary: primaryDark,
    onPrimary: whiteHighEmphasis,
    secondary: secondary,
    secondaryVariant: secondaryLight,
    onSecondary: blackHighEmphasis,
    error: Colors.red,
    onError: blackHighEmphasis,
    background: darkModeColor,
    onBackground: whiteHighEmphasis,
    surface: darkModeColor,
    onSurface: whiteHighEmphasis,
    brightness: Brightness.dark,
  );

  static final ThemeData darkTheme = ThemeData(
    unselectedWidgetColor: whiteHighEmphasis,
    appBarTheme: AppBarTheme(color: primaryDark),
    brightness: Brightness.dark,
    fontFamily: "Source Sans Pro",
    scaffoldBackgroundColor: darkModeOffBlack,
    dialogBackgroundColor: darkModeOffBlack,
    cardColor: darkModeColor,
    canvasColor: darkModeColor,
    backgroundColor: darkModeColor,
    cardTheme: CardTheme(shadowColor: Colors.white.withAlpha(90)),
    colorScheme: darkColorScheme,
    iconTheme: whiteIconThemeData,
    toggleableActiveColor: secondary,
    accentColor: primaryLight,
    primaryColor: primaryDark,
    primaryColorLight: primaryLight,
    primaryColorDark: primaryDark,
    primaryTextTheme: whiteTextTheme,
    primaryIconTheme: whiteIconThemeData,
    secondaryHeaderColor: primaryDark,
    buttonColor: primaryDark,
    buttonTheme: ButtonThemeData(
      buttonColor: primaryDark,
      highlightColor: secondaryLight,
    ),
    textTheme: whiteTextTheme,
  );
}
