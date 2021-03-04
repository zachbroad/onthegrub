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

  static final Color whiteOpacity70 = Colors.white.withOpacity(.70);
  static final Color blackOpacity70 = Colors.black.withOpacity(.70);

  static final IconThemeData whiteIconThemeData = IconThemeData(color: whiteOpacity70);

  static final TextTheme whiteTextTheme = TextTheme(
    caption: TextStyle(color: whiteOpacity70),
    headline1: TextStyle(color: whiteOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline2: TextStyle(color: whiteOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline3: TextStyle(color: whiteOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline4: TextStyle(color: whiteOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline5: TextStyle(color: whiteOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline6: TextStyle(color: whiteOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    button: TextStyle(color: whiteOpacity70, fontFamily: "Source Sans Pro"),
    bodyText1: TextStyle(color: whiteOpacity70, fontFamily: "Source Serif Pro"),
    bodyText2: TextStyle(color: whiteOpacity70, fontFamily: "Source Sans Pro"),
  );

  static final IconThemeData blackIconThemeData = IconThemeData(color: blackOpacity70);

  static final TextTheme blackTextTheme = TextTheme(
    caption: TextStyle(
      color: blackOpacity70,
    ),
    headline1: TextStyle(color: blackOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline2: TextStyle(color: blackOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline3: TextStyle(color: blackOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline4: TextStyle(color: blackOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline5: TextStyle(color: blackOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    headline6: TextStyle(color: blackOpacity70, fontFamily: "Source Sans Pro", fontWeight: FontWeight.bold),
    button: TextStyle(color: blackOpacity70, fontFamily: "Source Sans Pro"),
    bodyText1: TextStyle(color: blackOpacity70, fontFamily: "Source Serif Pro"),
    bodyText2: TextStyle(color: blackOpacity70, fontFamily: "Source Sans Pro"),
  );

  static final ColorScheme lightColorScheme = ColorScheme.light(
    primaryVariant: primaryLight,
    primary: primary,
    onPrimary: blackOpacity70,
    secondary: secondary,
    secondaryVariant: secondaryLight,
    onSecondary: whiteOpacity70,
    error: Colors.red,
    onError: whiteOpacity70,
    background: Colors.white,
    onBackground: blackOpacity70,
    surface: Colors.white,
    onSurface: blackOpacity70,
    brightness: Brightness.light,
  );

  static final ThemeData lightTheme = ThemeData(
    unselectedWidgetColor: blackOpacity70,
    appBarTheme: AppBarTheme(color: primary),
    brightness: Brightness.light,
    fontFamily: "Source Sans Pro",
    scaffoldBackgroundColor: lightModeOffWhite,
    dialogBackgroundColor: lightModeOffWhite,
    backgroundColor: Colors.white,
    colorScheme: lightColorScheme,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    iconTheme: IconThemeData(color: blackOpacity70),
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
    onPrimary: whiteOpacity70,
    secondary: secondary,
    secondaryVariant: secondaryLight,
    onSecondary: blackOpacity70,
    error: Colors.red,
    onError: blackOpacity70,
    background: darkModeColor,
    onBackground: whiteOpacity70,
    surface: darkModeColor,
    onSurface: whiteOpacity70,
    brightness: Brightness.dark,
  );

  static final ThemeData darkTheme = ThemeData(
    unselectedWidgetColor: whiteOpacity70,
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
