import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/blocs/location_cubit.dart';
import 'package:onthegrubv2/config/themes/state_notifier.dart';
import 'package:onthegrubv2/config/themes/theme.dart';
import 'package:onthegrubv2/core/auth/bloc/auth_cubit.dart';
import 'package:onthegrubv2/core/auth/screens/splash_screen.dart';
import 'package:onthegrubv2/core/auth/models/user.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/services/navigation_service.dart';
import 'package:provider/provider.dart';

import 'core/auth/login/bloc/login_cubit.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppStateNotifier>(
        create: (_) => AppStateNotifier(),
      ),
      ChangeNotifierProvider<User>(
        create: (_) => User(),
      ),
      BlocProvider(create: (_) => LocationCubit()),
      BlocProvider(
        create: (_) => AuthCubit(),
      ),
      BlocProvider(
        create: (_) => LoginCubit(),
      )
    ],
    child: Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return Consumer<User>(
          builder: (context, user, child) {
            return MaterialApp(
              navigatorKey: NavigationService.instance.navigationKey,
              debugShowCheckedModeBanner: false,
              title: 'OnTheGrub',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              routes: Routes.all(),
              initialRoute: SplashScreen.routeName,
            );
          },
        );
      },
    ),
  ));
}
