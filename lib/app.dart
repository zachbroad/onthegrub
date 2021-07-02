import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/blocs/location_cubit.dart';
import 'package:onthegrubv2/config/routes/router.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:provider/provider.dart';

class AppGlobals {
  BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height - ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding = _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  AppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    AppRouter.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => LocationCubit()),
        // BlocProvider(create: (_) => AuthCubit()),
        // BlocProvider(create: (_) => LoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OnTheGrub',
        onGenerateRoute: AppRouter.router.generator,
        darkTheme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Color(0xFF252525),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xFF2C2C2C),
          accentColor: AppColors().mainDarkColor(1),
          hintColor: AppColors().secondDarkColor(1),
          focusColor: AppColors().accentDarkColor(1),
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 20.0, color: AppColors().secondDarkColor(1)),
            display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors().secondDarkColor(1)),
            display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: AppColors().secondDarkColor(1)),
            display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: AppColors().mainDarkColor(1)),
            display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: AppColors().secondDarkColor(1)),
            subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: AppColors().secondDarkColor(1)),
            title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors().mainDarkColor(1)),
            body1: TextStyle(fontSize: 12.0, color: AppColors().secondDarkColor(1)),
            body2: TextStyle(fontSize: 14.0, color: AppColors().secondDarkColor(1)),
            caption: TextStyle(fontSize: 12.0, color: AppColors().secondDarkColor(0.6)),
          ),
        ),
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          brightness: Brightness.light,
          accentColor: AppColors().mainColor(1),
          focusColor: AppColors().accentColor(1),
          hintColor: AppColors().secondColor(1),
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 20.0, color: AppColors().secondColor(1)),
            display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors().secondColor(1)),
            display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: AppColors().secondColor(1)),
            display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: AppColors().mainColor(1)),
            display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: AppColors().secondColor(1)),
            subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: AppColors().secondColor(1)),
            title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors().mainColor(1)),
            body1: TextStyle(fontSize: 12.0, color: AppColors().secondColor(1)),
            body2: TextStyle(fontSize: 14.0, color: AppColors().secondColor(1)),
            caption: TextStyle(fontSize: 12.0, color: AppColors().accentColor(1)),
          ),
        ),
      ),
    );
  }
}

class AppColors {
//  Color _mainColor = Color(0xFFFF4E6A);
  Color _mainColor = Color(0xFFea5c44);
  Color _mainDarkColor = Color(0xFFea5c44);
  Color _secondColor = Color(0xFF344968);
  Color _secondDarkColor = Color(0xFFccccdd);
  Color _accentColor = Color(0xFF8C98A8);
  Color _accentDarkColor = Color(0xFF9999aa);

  Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }
}
