import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/screens/auth/forgot_password.dart';
import 'package:onthegrubv2/screens/auth/login.dart';
import 'package:onthegrubv2/screens/auth/registration/user_registration.dart';
import 'package:onthegrubv2/screens/splash.dart';

class Routes {
  static Map<String, WidgetBuilder> all() {
    return {
      SplashScreen.routeName: (BuildContext context) => SplashScreen(),
//       AnnouncementList.routeName: (BuildContext context) => AnnouncementList(),
//      AnnouncementDetail.routeName: (BuildContext context) => AnnouncementDetail(),

      // Events
//       EventsIndex.routeName: (BuildContext context) => EventsIndex(),

      // Auth
      ForgotPassword.routeName: (BuildContext context) => ForgotPassword(),
      LoginScreen.routeName: (BuildContext context) => LoginScreen(),
      Registration.routeName: (BuildContext context) => Registration(),
      SplashScreen.routeName: (BuildContext context) => SplashScreen(),

      // NOTIFICATIONS

      // NotificationsIndex.routeName: (BuildContext context) => NotificationsIndex(),

      // // Dashboard
      // DashboardDetail.routeName: (BuildContext context) => DashboardDetail(),
      // DashboardIndex.routeName: (BuildContext context) => DashboardIndex(),

      // Trucks
      // FavoriteTrucksScreen.routeName: (BuildContext context) => FavoriteTrucksScreen(),
      // IndexScreen.routeName: (BuildContext context) => IndexScreen(),
      // TruckAbout.routeName: (BuildContext context) => TruckAbout(),
      // TruckProfile.routeName: (BuildContext context) => TruckProfile(),
      // TruckCaterRequestForm.routeName: (BuildContext context) => TruckCaterRequestForm(),
      // TruckCaterRequestList.routeName: (BuildContext context) => TruckCaterRequestList(),
      // Menu
      // MenuCategoryView.routeName: (BuildContext context) => MenuCategoryView(),
      // TruckMenuIndexView.routeName: (BuildContext context) => TruckMenuIndexView(),
      // TruckMenuItemView.routeName: (BuildContext context) => TruckMenuItemView(),
      // Reviews
      // TruckReviewsListIndex.routeName: (BuildContext context) => TruckReviewsListIndex(),

      // Create Truck
      // CreateTruck.routeName: (BuildContext context) => CreateTruck(),

      // Manage Truck
      // ManageTruck.routeName: (BuildContext context) => ManageTruck(),
      // Details
      // ManageTruckTitle.routeName: (BuildContext context) => ManageTruckTitle(),
      // ManageTruckDescription.routeName: (BuildContext context) => ManageTruckDescription(),
      // ManageTruckMenu.routeName: (BuildContext context) => ManageTruckMenu(),
      // ManageTruckTags.routeName: (BuildContext context) => ManageTruckTags(),
      // Contact
      // ManageTruckPhone.routeName: (BuildContext context) => ManageTruckPhone(),
      // ManageTruckWebsite.routeName: (BuildContext context) => ManageTruckDescription(),
      // Availabililty
      // ManageTruckLocation.routeName: (BuildContext context) => ManageTruckLocation(),
      // TruckScheduleScreen.routeName: (BuildContext context) => TruckScheduleScreen(),

      // User
      // UserSettings.routeName: (BuildContext context) => UserSettings(),
      // ManageEmail.routeName: (BuildContext context) => ManageEmail(),
      // ManageFirstName.routeName: (BuildContext context) => ManageFirstName(),
      // ManageLastName.routeName: (BuildContext context) => ManageLastName(),
      // ManagePhoneNumber.routeName: (BuildContext context) => ManagePhoneNumber(),
      // ManageUsername.routeName: (BuildContext context) => ManageUsername(),
      // UserProfile.routeName: (BuildContext context) => UserProfile(),

      // Support
      // SupportScreen.routeName: (BuildContext context) => SupportScreen(),
    };
  }
}
