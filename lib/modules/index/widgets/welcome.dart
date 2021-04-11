import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onthegrubv2/constants/assets_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({
    Key key,
  }) : super(key: key);

  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> with TickerProviderStateMixin {
  var notInterested = false;
  var closed = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var boxDecoration = BoxDecoration(
      color: theme.colorScheme.primary,
      border: Border.all(color: theme.colorScheme.onSecondary.withOpacity(0.95)),
    );
    return AnimatedSize(
      vsync: this,
      duration: Duration(milliseconds: 250),
      curve: Curves.bounceIn,
      child: Container(
        height: this.closed ? 0 : null,
        child: AnimatedOpacity(
          opacity: this.closed ? 0.0 : 1.0,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 1000),
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0, bottom: 12.0),
            child: Stack(
              children: [
                // TODO fix (x) widget
                AnimatedCrossFade(
                  crossFadeState: notInterested ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 125),
                  secondChild: Container(
                    decoration: boxDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: theme.primaryColorDark,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Grub out!", style: theme.textTheme.headline5.apply(color: Colors.white)),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  child: Image.asset(Assets.grubtruck),
                                  height: 64,
                                  width: 64,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.67,
                            child: Text("If you ever change your mind, you can create a Truck in the Grub Manager.",
                                style: theme.textTheme.bodyText2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      closed = true;
                                      _dismissWidget();
                                    });
                                  },
                                  minWidth: 170,
                                  child: Text("Got it!"),
                                  color: theme.colorScheme.primaryVariant)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  firstChild: Container(
                    decoration: boxDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: theme.primaryColorDark,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Welcome to OnTheGrub", style: theme.textTheme.headline5.apply(color: Colors.white)),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  child: Image.asset(Assets.grubtruck),
                                  height: 64,
                                  width: 64,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.67,
                            child: Text(
                              "Are you a food truck owner?\nRegister your truck on OnTheGrub today for free!",
                              style: theme.textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    notInterested = true;
                                    _dismissWidget();
                                  });
                                },
                                child: Text(
                                  "Not interested",
                                  style: theme.textTheme.bodyText2,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
//                                  Navigator.pushNamed(context, DashboardIndex.routeName);
                                },
                                child: Text("More info"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -10,
                    left: -10,
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      color: theme.colorScheme.surface,
                      child: InkWell(
                        child: Icon(Icons.close, size: 24.0),
                        onTap: () {
                          setState(() {
                            notInterested = true;
                            closed = true;
                            _dismissWidget();
                          });
                        },
                      ),
                    ),
                    width: 24.0,
                    height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _dismissWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('welcome_dismissed', true);
  }
}
