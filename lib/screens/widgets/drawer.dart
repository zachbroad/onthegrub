import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onthegrub/models/user.dart';
import 'package:onthegrub/screens/auth/login.dart';
import 'package:onthegrub/screens/auth/splash_screen.dart';
import 'package:onthegrub/screens/dashboard/index.dart';
import 'package:onthegrub/screens/truck/manage/create/create.dart';
import 'package:onthegrub/screens/user/account/settings.dart';
import 'package:onthegrub/screens/user/profile.dart';
import 'package:onthegrub/services/api.dart';
import 'package:onthegrub/themes/state_notifier.dart';
import 'package:onthegrub/util/authentication.dart';
import 'package:onthegrub/screens/widgets/fadeimage.dart';
import 'package:onthegrub/util/file.dart';
import 'package:provider/provider.dart';

class GrubDrawer extends StatefulWidget {
  @override
  _GrubDrawerState createState() => _GrubDrawerState();
}

class _GrubDrawerState extends State<GrubDrawer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, child) {
        var profilePictureSize = 72.0;
        return Drawer(
          elevation: 0,
          child: Container(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('${user.firstName} ${user.lastName}'),
                  accountEmail: Text('@${user.username}'.toUpperCase()),
//                  arrowColor: Colors.white,
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Hero(
                      tag: 'user_profile',
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, UserProfile.routeName, arguments: user),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: FadeImageWidget(
                            image: Image.network(
                              user.profilePicture,
                              fit: BoxFit.fill,
                              width: profilePictureSize,
                              height: profilePictureSize,
                            ),
                            fit: BoxFit.fill,
                            width: profilePictureSize,
                            height: profilePictureSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                user.trucks.length > 0
                    ? ListTile(
                        title: Text(
                          'Dashboard',
//                          style: style,
                        ),
                        subtitle: Text("Manage your trucks"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, DashboardIndex.routeName);
                        },
                      )
                    : ListTile(
                        title: Text("Add my foodtruck"),
                        subtitle: Text("Are you a food truck owner?"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, CreateTruck.routeName);
                        },
                      ),

                ListTile(
                  title: Text(
                    'Favorites',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      '/trucks/favorites/',
                    );
                  },
                ),

                // DIVIDER
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),

                // DARK MODE
                ListTile(
                  title: Text(
                    "Dark mode",
                  ),
                  trailing: Switch(
                    value: Provider.of<AppStateNotifier>(context).isDarkMode,
                    onChanged: (boolVal) {
                      Provider.of<AppStateNotifier>(context, listen: false).updateTheme(boolVal);
                    },
                  ),
                ),

                // ACCOUNT SETTINGS
                ListTile(
                  title: Text(
                    "Settings",
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, UserSettings.routeName);
                  },
                ),

                // FEEDBACK
                ListTile(
                  title: Text(
                    "Send feedback",
                  ),
                  onTap: () {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        TextEditingController _feedback = TextEditingController();
                        var _image;
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                'Send Feedback',
                              ),
                            ),
                            content: Container(
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                child: ListBody(
                                  children: <Widget>[
                                    TextFormField(
                                      minLines: 5,
                                      maxLines: 10,
                                      controller: _feedback,
                                      decoration: InputDecoration(
                                        hintText:
                                            "In as much detail as possible, describe your issue(s), or provide your idea(s). You may use supporting images if you'd like.",
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(12.0),
                                      child: _image != null ? Image.file(_image, height: 284, width: 250) : Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2.9,
                                    child: IconButton(
                                      icon: Icon(Icons.image),
                                      onPressed: () async {
                                        File image = await getImageFromUserGallery();
                                        if (image != null)
                                          setState(() {
                                            _image = image;
                                          });
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                    onPressed: () async {
                                      int status = await APIService.postFeedback(user.pk, _feedback.text, _image);
                                      if (status == 201) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          );
                        });
                      },
                    );
                  },
                ),

                ListTile(
                  title: Text(
                    "Logout",
                  ),
                  onTap: () async {
                    await Auth.logout();
                    user = null;
                    Navigator.pushNamedAndRemoveUntil(context, Login.routeName, ModalRoute.withName(SplashScreen.routeName));
                  },
                  trailing: Icon(Icons.exit_to_app, color: Theme.of(context).accentColor),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
