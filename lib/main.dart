import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/blocs/location_cubit.dart';
import 'package:onthegrubv2/config/themes/state_notifier.dart';
import 'package:onthegrubv2/config/themes/theme.dart';
import 'package:onthegrubv2/core/auth/splash_screen.dart';
import 'package:onthegrubv2/core/auth/login/models/user.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
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
    ],
    child: Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return Consumer<User>(
          builder: (context, user, child) {
            return MaterialApp(
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
