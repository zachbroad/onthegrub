import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:onthegrubv2/blocs/location_cubit.dart';
import 'package:onthegrubv2/data/models/user.dart';
import 'package:onthegrubv2/routes.dart';
import 'package:onthegrubv2/screens/auth/login.dart';
import 'package:onthegrubv2/screens/auth/splash_screen.dart';
import 'package:onthegrubv2/themes/state_notifier.dart';
import 'package:onthegrubv2/themes/theme.dart';
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
      BlocProvider(
        create: (_) => LocationCubit(Location()),
      ),
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
