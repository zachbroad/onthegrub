import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:onthegrub/blocs/location_bloc.dart';
import 'package:onthegrub/models/user_registration.dart';
import 'package:onthegrub/screens/auth/registration/widgets/last_page_button.dart';
import 'package:onthegrub/screens/truck/manage/create/widgets/places.dart';
import 'package:onthegrub/services/api.dart';
import 'package:onthegrub/services/auth.dart';
import 'package:provider/provider.dart';

class UserRegistrationLocation extends StatefulWidget {
  final Function nextPage;
  final Function previousPage;

  UserRegistrationLocation(this.nextPage, this.previousPage);

  @override
  _UserRegistrationLocationState createState() => _UserRegistrationLocationState();
}

class _UserRegistrationLocationState extends State<UserRegistrationLocation> {
  GoogleMapController _mapController;
  bool locationRecieved = false;
  UserRegistration user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserRegistration>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    LocationBloc locationBloc = Provider.of<LocationBloc>(context);
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [colorScheme.primaryVariant, colorScheme.primary], begin: Alignment.topCenter),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * (!locationRecieved ? 0.15 : .1)),
            child: Container(
              margin: EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Where are you located?',
                    style: Theme.of(context).textTheme.headline4.apply(color: Colors.black87),
                  ),
                  Text(
                    'This location will only be used to show you food truck results',
                    style: TextStyle(color: Colors.black.withOpacity(.7)),
                  ),
                  locationBloc.userLocation != null ? _userLocationMap(context) : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: Text('CURRENT LOCATION'),
                          onPressed: () async {
                            await locationBloc.checkPermissions();
                            if (locationRecieved) {
                              setState(() {
                                _mapController.animateCamera(CameraUpdate.newLatLng(locationBloc.userLocation));
                              });
                            }
                          },
                        ),
                        ElevatedButton(
                          child: Text('ENTER ADDRESS'),
                          onPressed: () async {
                            List args = await _handlePressButton();
                            if (args[0] != null && args[1] != null) {
                              await locationBloc.stopListen(add: args[0], location: args[1]);
                              if (locationRecieved) {
                                setState(() {
                                  locationBloc.userLocation = args[1];
                                  _mapController.animateCamera(CameraUpdate.newLatLng(locationBloc.userLocation));
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
      LastPageButton(onPressed: widget.previousPage),
      Positioned(
        right: 0,
        top: 30,
        child: locationBloc.userLocation != null
            ? Container(
                child: TextButton(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.black87),
                  ),
                  onPressed: () async {
                    var response = await AuthService.register(user);
                    print(response.statusCode);
                    if (response.statusCode == 201 || response.statusCode == 200) {
                      // If the user signed up for the mailing list and their email is valid
                      user.mailingList ?? await APIService.signUpMailingList(user.email);
                      Navigator.pop(context, true);
                    } else if (response.statusCode == 400) {
                      // Check for errors thrown by db
                      Map<String, dynamic> data = json.decode(response.body);
                      data.forEach((key, value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('$key: ${value[0]}'),
                        ));
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(response.statusCode.toString()),
                      ));
                    }
                  },
                ),
              )
            : Container(),
      ),
    ]);
  }

  _userLocationMap(context) {
    locationRecieved = true;
    Size size = MediaQuery.of(context).size;
    LocationBloc userLocationBloc = Provider.of<LocationBloc>(context);

    Map<MarkerId, Marker> markers = {};

    final MarkerId markerId = MarkerId(user.username.toString());

    // Current truck marker
    if (userLocationBloc.userLocation != null)
      markers[markerId] = Marker(
          markerId: markerId,
          position: userLocationBloc.userLocation,
          infoWindow: InfoWindow(
            title: user.username,
            snippet: 'This is you!',
          ));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          height: size.height * .45,
          width: size.width,
          child: userLocationBloc.userLocation != null
              ? GoogleMap(
                  myLocationEnabled: Provider.of<LocationBloc>(context, listen: false).isListening,
                  initialCameraPosition: CameraPosition(target: userLocationBloc.userLocation),
                  onMapCreated: (controller) {
                    _mapController = controller;
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: userLocationBloc.userLocation, zoom: 14),
                      ),
                    );
                  },
                  markers: Set<Marker>.of(markers.values),
                )
              : Container()),
    );
  }

  Future<List> _handlePressButton() async {
    String address;
    Prediction selection = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay,
      language: "en",
      components: [Component(Component.country, "us")],
    );
    LatLng geolocation = await displayPrediction(selection);
    if (selection != null) address = selection.description;

    return [address, geolocation];
  }
}
