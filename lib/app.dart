import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/blocs/location_cubit.dart';
import 'package:onthegrubv2/config/routes/router.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/config/themes/state_notifier.dart';
import 'package:onthegrubv2/config/themes/theme.dart';
import 'package:onthegrubv2/core/auth/bloc/auth_cubit.dart';
import 'package:onthegrubv2/core/auth/login/bloc/login_cubit.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

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
        ChangeNotifierProvider<AppStateNotifier>(create: (_) => AppStateNotifier()),
        BlocProvider(create: (_) => LocationCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => LoginCubit())
      ],
      child: Consumer<AppStateNotifier>(
        builder: (context, appState, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OnTheGrub',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: AppRouter.router.generator,
          );
        },
      ),
    );
  }
}
