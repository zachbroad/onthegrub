import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onthegrubv2/models/user.dart';
import 'package:onthegrubv2/routes.dart';
import 'package:onthegrubv2/screens/auth/login.dart';
import 'package:onthegrubv2/screens/trucks.dart';
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
      // ChangeNotifierProvider<LocationCubit>(
      //   create: (_) => LocationCubit(),
      // ),
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
              initialRoute: TrucksList.routeName,
            );
          },
        );
      },
    ),
  ));
}
